# Copyright 2022 Nicolas Jouanin <nicolas.jouanin@gmail.com>
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# SPDX-License-Identifier: Apache-2.0

defmodule Exagon.Bindings.BindingsTest do
  use ExUnit.Case
  alias Exagon.BindingFixtures.TestBinding
  alias Exagon.BindingFixtures.TestThing

  describe "Binding definition" do
    test "create binding" do
      assert "test" == TestBinding.name()
    end

    test "create thing definition" do
      the_thing = %TestThing{}

      assert %TestThing{
               __def__: %Exagon.Bindings.ThingDef{
                 name: "test:testthing",
                 binding: Exagon.BindingFixtures.TestBinding,
                 properties: [
                   %Exagon.Bindings.PropertyDef{
                     description: "Prop1 description",
                     label: "Prop1 label",
                     name: :prop1,
                     type: :string
                   },
                   %Exagon.Bindings.PropertyDef{
                     description: :string,
                     label: :string,
                     name: :prop2,
                     type: :string
                   }
                 ]
               }
             } = the_thing
    end
  end
end
