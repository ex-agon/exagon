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

defmodule Exagon.Schema do
  defmacro __using__(_) do
    quote do
      use Ecto.Schema
      @timestamps_opts [type: :utc_datetime_usec]
      @primary_key {:id, :binary_id, autogenerate: true}
      @foreign_key_type :binary_id

      import Ecto
      import Ecto.Changeset
      import Ecto.Query
    end
  end
end
