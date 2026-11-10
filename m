Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794324468;
	b=3ThIg0p4xlXysARj40nMK/e33SD07DlScDTX87qy//JC1qkLWx6dz9mvrWR4DF+wgWdg
	 NU/F8WFSQDeYXV213XrN1zHQDbE8uQpPTh/8DhvlM08hs7amMogdEmAwwiRtBOSjZWeTO
	 T+o0DeArxULkpGL8j/MSJBPQLktcBgWgWj9pxwD64XfxYDFV8E4rGfuaGoXImUt3p9sl/
	 h5OF96SBD+6hs6mcVS+5qfQDCe2yD2AG/baVzlbW4+EIRx8tdnhEcuxsfm9YLAjX6jBOs
	 aVjfiF7dEmE7zHXAAS+6ejM4nRfVi+hpoYQgnv45Uwf+l4XOCXKJlAvDesDu2jsGafQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794324468;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=hI6RrJGoR32nHOun34r6MzkSJfi8TLtc7U1OwfAK63U=;
	b=3X78Q9NhWvKUqdiVAXy2s/ucjBPwN8kBLQ3vHt8aXuvOMK634Pz85eX/uwoR/zvqgd3V
	 GE5Bg4UsUjAhTTQh29YPCOde0C9SzkJH1y1KNW/ZCgoJoWk5pmGMLr7I4BUfEJnLdBsTI
	 UMwwoGDuuc1hNItKOk22CKQ/X36aoeolPMdCGgK2sRXFLrWYP71uNwXGqwadbywHOfPfV
	 DlYqXSShlVrWOYoFVbFgWj9FDR2MBBw2m19Oy8ooHnra7XGR3S0IxVDKQqH6AGzRI2UT8
	 5uHJmAQ+G9BRN6rHiQ6Or+xpiUDBUmbEJjKGJfOpx9csRTaWY3+7z9cPIUEJSdN49MQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CN2EP6Il;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41926606A31C;
	Tue, 10 Nov 2026 15:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CN2EP6Il
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CF791F0089F;
	Tue, 10 Nov 2026 15:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794324467;
	bh=hI6RrJGoR32nHOun34r6MzkSJfi8TLtc7U1OwfAK63U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=CN2EP6Il+KD+On+yiFtvOfH0dAkLCu2EqAFqCDK7WLp/Av04Wrv5AsRcMYjuvXotV
	 icurtL59ZKqwW8hXdJsmASUHo8jS+Y1oRds+Q0pTx8N8SVHK95574MoZA+gSq/oV1M
	 PQ2dwA+5Uva0fJSWn2Nrl5D2t8fBqw33muc3WtSWrlNUryrUJMwTrSz3bG6fMrJBZT
	 i/SfRNwjpXCgAvaKayWhO2BwmvVeXdpf7wv0lnAZYGWV25I5Ohc//BdUNSCEUeg67I
	 s3aAq+xrjImJhh8vQ0PMqMjK1+E6rgG15wRB9tGCsY+3hwKMrheL5pMpNQ7ekwEuaF
	 qnIUW991CzyDA==
Message-ID: <4290bbfc-c72d-49d4-9d0c-66f316db9dd3@kernel.org>
Date: Tue, 10 Nov 2026 15:27:44 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v11 2/3] bpftool: Add recursive map dumping
To: Tianyi Chen <hi@tychen.cc>, bpf@vger.kernel.org
Cc: andrii@kernel.org, eddyz87@gmail.com, ihor.solodrai@linux.dev,
 linux-kselftest@vger.kernel.org, shuah@kernel.org, daniel@iogearbox.net,
 ast@kernel.org, alexei.starovoitov@gmail.com, skokovmaksimevg@gmail.com
References: <cover.1793818386.git.hi@tychen.cc>
 <9d939026aea3c4a2d4d26702de1080c6733ad566.1793818386.git.hi@tychen.cc>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <9d939026aea3c4a2d4d26702de1080c6733ad566.1793818386.git.hi@tychen.cc>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 04/11/2026 18:54, Tianyi Chen wrote:
> Dumping an array_of_maps or a hash_of_maps shows the IDs of the inner
> maps but not their contents. Add a recursive keyword to map dump that
> also dumps the inner map referenced by each entry, in that entry. JSON
> entries gain an "inner_map" object next to "inner_map_id", and plain
> output prints the inner map after the entry line. The output without
> the keyword is unchanged.
> 
> The kernel supports a single level of map-in-map, so inner maps have
> no inner maps of their own. Each inner map is opened by ID when its
> entry is printed, dumped and closed, which needs one more map FD. An
> inner map shared by several entries is dumped in each of them. If an
> inner map cannot be opened, for example because it was replaced after
> the outer lookup, the error is reported in that entry and the dump
> continues.
> 
> Link: https://github.com/libbpf/bpftool/issues/58
> Suggested-by: Alexei Starovoitov <ast@kernel.org>
> Assisted-by: LLM
> Signed-off-by: Tianyi Chen <hi@tychen.cc>
> ---
>  .../bpf/bpftool/Documentation/bpftool-map.rst |  9 ++-
>  tools/bpf/bpftool/bash-completion/bpftool     |  3 +
>  tools/bpf/bpftool/map.c                       | 59 +++++++++++++++++--
>  3 files changed, 65 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/bpf/bpftool/Documentation/bpftool-map.rst b/tools/bpf/bpftool/Documentation/bpftool-map.rst
> index e4ed7e701c9e4..729baab2b7922 100644
> --- a/tools/bpf/bpftool/Documentation/bpftool-map.rst
> +++ b/tools/bpf/bpftool/Documentation/bpftool-map.rst
> @@ -29,7 +29,7 @@ MAP COMMANDS
>  | **bpftool** **map create**     *FILE* **type** *TYPE* **key** *KEY_SIZE* **value** *VALUE_SIZE* \
>  |     **entries** *MAX_ENTRIES* **name** *NAME* [**flags** *FLAGS*] [**inner_map** *MAP*] \
>  |     [**offload_dev** *NAME*]
> -| **bpftool** **map dump**       *MAP*
> +| **bpftool** **map dump**       *MAP* [**recursive**]
>  | **bpftool** **map update**     *MAP* [**key** *DATA*] [**value** *VALUE*] [*UPDATE_FLAGS*]
>  | **bpftool** **map lookup**     *MAP* [**key** *DATA*]
>  | **bpftool** **map getnext**    *MAP* [**key** *DATA*]
> @@ -87,10 +87,15 @@ bpftool map create *FILE* type *TYPE* key *KEY_SIZE* value *VALUE_SIZE*  entries
>      Keyword **offload_dev** expects a network interface name, and is used to
>      request hardware offload for the map.
>  
> -bpftool map dump    *MAP*
> +bpftool map dump    *MAP* [recursive]
>      Dump all entries in a given *MAP*.  In case of **name**, *MAP* may match
>      several maps which will all be dumped.
>  
> +    With **recursive**, each entry of an **array_of_maps** or **hash_of_maps**
> +    also has the dump of the inner map that it refers to. An inner map that
> +    cannot be opened, for example because it was replaced, is reported as an
> +    error in that entry.
> +
>  bpftool map update  *MAP* [key *DATA*] [value *VALUE*] [*UPDATE_FLAGS*]
>      Update map entry for a given *KEY*.
>  
> diff --git a/tools/bpf/bpftool/bash-completion/bpftool b/tools/bpf/bpftool/bash-completion/bpftool
> index a28af31937ad4..78fdb9396e96f 100644
> --- a/tools/bpf/bpftool/bash-completion/bpftool
> +++ b/tools/bpf/bpftool/bash-completion/bpftool
> @@ -718,6 +718,9 @@ _bpftool()
>                              return 0
>                              ;;
>                          *)
> +                            if [[ $command == dump && $cword -eq 5 ]]; then
> +                                COMPREPLY=( $( compgen -W 'recursive' -- "$cur" ) )
> +                            fi
>                              return 0
>                              ;;
>                      esac
> diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
> index b150a06a25085..fc820c07e9f4f 100644
> --- a/tools/bpf/bpftool/map.c
> +++ b/tools/bpf/bpftool/map.c
> @@ -22,6 +22,9 @@
>  #include "main.h"
>  
>  static struct hashmap *map_table;
> +static bool recursive_dump;
> +
> +static void dump_inner_map(__u32 id);
>  
>  static bool map_is_per_cpu(__u32 type)
>  {
> @@ -140,9 +143,14 @@ static void print_entry_json(struct bpf_map_info *info, unsigned char *key,
>  		print_hex_data_json(key, info->key_size);
>  		jsonw_name(json_wtr, "value");
>  		print_hex_data_json(value, info->value_size);
> -		if (map_is_map_of_maps(info->type))
> +		if (map_is_map_of_maps(info->type)) {
>  			jsonw_uint_field(json_wtr, "inner_map_id",
>  					 *(unsigned int *)value);
> +			if (recursive_dump) {
> +				jsonw_name(json_wtr, "inner_map");
> +				dump_inner_map(*(unsigned int *)value);
> +			}
> +		}
>  		if (btf) {
>  			struct btf_dumper d = {
>  				.btf = btf,
> @@ -273,6 +281,8 @@ static void print_entry_plain(struct bpf_map_info *info, unsigned char *key,
>  		}
>  
>  		printf("\n");
> +		if (recursive_dump && map_is_map_of_maps(info->type))
> +			dump_inner_map(*(unsigned int *)value);
>  	} else {
>  		unsigned int step;
>  		int i;
> @@ -935,6 +945,36 @@ map_dump(int fd, struct bpf_map_info *info, json_writer_t *wtr,
>  	return err;
>  }
>  
> +/* The kernel has one level of map-in-map: inner maps have no inner maps. */
> +static void dump_inner_map(__u32 id)
> +{
> +	LIBBPF_OPTS(bpf_get_fd_by_id_opts, opts, .open_flags = BPF_F_RDONLY);
> +	struct bpf_map_info info = {};
> +	json_writer_t *btf_wtr = NULL;
> +	__u32 len = sizeof(info);
> +	int fd;
> +
> +	fd = bpf_map_get_fd_by_id_opts(id, &opts);
> +	if (fd < 0) {
> +		p_err("can't get map by id (%u): %s", id, strerror(errno));
> +		return;
> +	}
> +	if (bpf_map_get_info_by_fd(fd, &info, &len)) {
> +		p_err("can't get map info: %s", strerror(errno));
> +		goto out;
> +	}
> +
> +	if (!json_output && info.btf_value_type_id)
> +		btf_wtr = get_btf_writer();
> +
> +	map_dump(fd, &info, json_output ? json_wtr : btf_wtr, true);


Hi Tianyi, thanks for this version!

With the design in the newer versions (dump as soon as you find the
entry), the plain output will look something like this:

   key: 01 00 00 00  inner_map_id: 80
   80: hash  name c1202206_in2  flags 0x0
   Found 0 elements
   key: 00 00 00 00  inner_map_id: 79
   79: hash  name c1202206_in1  flags 0x0
   key: 07 00 00 00  value: 09 00 00 00
   Found 1 element
   Found 2 elements

It's quite difficult to understand where each inner map starts and
stops. Can we have some sort of delimiter between maps (at least one
empty line, I think that's what we use when dumping several maps with
the same name?), and some sort of indentation or prefix character to
show inner map entries and items count, please?

pw-bot: cr

On a different note, we risk an infinite recursion here if the kernel
ever allows inner maps to recurse. I'm not aware that there is any plan
in that direction though, so it's probably fine to keep as-is for now.


> +
> +	if (btf_wtr)
> +		jsonw_destroy(&btf_wtr);
> +out:
> +	close(fd);
> +}
> +
>  static int do_dump(int argc, char **argv)
>  {
>  	json_writer_t *wtr = NULL, *btf_wtr = NULL;
> @@ -944,8 +984,8 @@ static int do_dump(int argc, char **argv)
>  	int *fds = NULL;
>  	int err = -1;
>  
> -	if (argc != 2)
> -		usage();
> +	if (!REQ_ARGS(2))
> +		return -1;
>  
>  	fds = malloc(sizeof(int));
>  	if (!fds) {
> @@ -956,6 +996,16 @@ static int do_dump(int argc, char **argv)
>  	if (nb_fds < 1)
>  		goto exit_free;
>  
> +	while (argc) {
> +		if (**argv && is_prefix(*argv, "recursive")) {
> +			NEXT_ARG();
> +			recursive_dump = true;
> +		} else {
> +			p_err("expected 'recursive', got: '%s'", *argv);
> +			goto exit_close;
> +		}
> +	}
> +
>  	if (json_output) {
>  		wtr = json_wtr;
>  	} else {
> @@ -1002,6 +1052,7 @@ static int do_dump(int argc, char **argv)
>  exit_free:
>  	free(fds);
>  	free_btf_vmlinux();
> +	recursive_dump = false;
>  	return err;
>  }
>  
> @@ -1510,7 +1561,7 @@ static int do_help(int argc, char **argv)
>  		"       %1$s %2$s create     FILE type TYPE key KEY_SIZE value VALUE_SIZE \\\n"
>  		"                                  entries MAX_ENTRIES name NAME [flags FLAGS] \\\n"
>  		"                                  [inner_map MAP] [offload_dev NAME]\n"
> -		"       %1$s %2$s dump       MAP\n"
> +		"       %1$s %2$s dump       MAP [recursive]\n"
>  		"       %1$s %2$s update     MAP [key DATA] [value VALUE] [UPDATE_FLAGS]\n"
>  		"       %1$s %2$s lookup     MAP [key DATA]\n"
>  		"       %1$s %2$s getnext    MAP [key DATA]\n"


Note that there may be some interaction between this series and the one
on batch lookups. With the approach suggested by Alexei - dump inner
maps as soon as you find them - it would probably make sense to exclude
the outer map from batch lookups when we do a recursive dump, to limit
the risk of inner maps being replaced in the meantime.

Thanks,
Quentin
