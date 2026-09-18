Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA37C370AE1;
	Fri, 18 Sep 2026 12:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789733918; cv=none; b=DEu66bWPLtf2yqEj5M5GwdWGkIe/Ll77Hx41YSIgQFSsIjv+KInMS8hu3gba1eWco5A16OqgOvVQW/8fxeMpB+ztXwiZ7eLBlJUrjsC0TAPvbMYGSetoofsJEmZoIshCZNHMq/6Jw/Y+4Ub7/PF3IN72F7blaTXfAnAncjc2Gr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789733918; c=relaxed/simple;
	bh=1tMWx52eDMSJ5kuW1x54Y81afg0th7L4tgVVEjKESI8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MYd2JsQ8k/cymaMzr9UqJLJus4LDGuwMzw7b9vx/nrRJl6rP8UiABsKIjBg1VICLxExx9wIDGFfOF0blj84gvSEhOlSLIEqrLTvYsOR0sk88GQu0WkoREOM/U8BRe1O+mUjlMtVAYr4ASgDOYdbRVJ2zV0XtNQo7sn1dXH/IhU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BMx1Hp8P; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BMx1Hp8P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0818A1F000FF;
	Fri, 18 Sep 2026 12:18:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789733916;
	bh=fijQVVWubcrIIFkq1jSU5MMkrclQr09lbJQLYiiwFV8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=BMx1Hp8PwfZ3DPOrcoRTeGiDr12DsycwP9bLFIdxBaUzWtbOKRLpUtczEEsJUzRbe
	 raBNHY4l80u7eFWlVZBYZPaRAI9HYnoXgMIwJ21KLP8hQ0Sh+bfQOYeGcgVSpYR0Rh
	 438VZVPHRZ2JanwIY6JjIle0KgfHey0kmOC5v5bhuKTCiIcUsrs+yDUcdwB/Mx5VLI
	 9XhC5k9RjWydI1MJJckyTrHDTRceLVYxfrI/zy2b2iJzvd8PWuNGdACPRaEqJOOOHK
	 VPAAS7W/gkeRAESDnMM2aRkYex2HtuiFyhip3KcHptBT9JoF1WgX2zTgxw/5aU2qVr
	 wjMsIdQI4D96Q==
Message-ID: <de9a4fa5-568d-4be5-bccd-04340be59352@kernel.org>
Date: Fri, 18 Sep 2026 13:18:33 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 1/2] bpftool: Read ring buffer maps with
 event_pipe
To: Tianyi Chen <diannaaav@gmail.com>, bpf@vger.kernel.org
Cc: andrii@kernel.org, eddyz87@gmail.com, ihor.solodrai@linux.dev,
 linux-kselftest@vger.kernel.org
References: <20260911025114.190899-1-diannaaav@gmail.com>
 <20260911025114.190899-2-diannaaav@gmail.com>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <20260911025114.190899-2-diannaaav@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2026-09-11 10:51 UTC+0800 ~ Tianyi Chen <diannaaav@gmail.com>
> From: Tianyi Chen <hi@tychen.cc>
> 
> map event_pipe only accepts perf event arrays, leaving no built-in way
> to inspect records produced through the BPF ring buffer API. Extend it
> to consume queued and live BPF_MAP_TYPE_RINGBUF records in plain or
> JSON output, retaining the existing perf event array path.
> 
> Ring buffers have a shared consumer position and no implicit CPU or
> timestamp. Document that this command consumes records rather than
> observing them passively, and reject perf-only CPU/index selectors.
> 
> A producer can keep ring_buffer__poll() busy after a stop signal, so
> return -EINTR from the record callback when stopping. Keep stdio out of
> the shared signal handler and preserve callback output errors.
> 
> Link: https://github.com/libbpf/bpftool/issues/54
> 
> Assisted-by: LLM
> Signed-off-by: Tianyi Chen <hi@tychen.cc>


Hi, thanks for picking these issues, and apologies for the delay.
I've seen your other series as well, but let's take them one after the
other, if you don't mind.

Note: When you reply, including to AI bots, please keep the context from
the discussion and avoid replying with only your answer in the email, it
makes it hard to follow the conversation.

The two patches from this series look good overall, I only have minor
comments, please see inline below.


> ---
>  .../bpf/bpftool/Documentation/bpftool-map.rst | 14 ++-
>  tools/bpf/bpftool/bash-completion/bpftool     |  4 +-
>  tools/bpf/bpftool/map_perf_ring.c             | 87 ++++++++++++++-----
>  3 files changed, 81 insertions(+), 24 deletions(-)
> 
> diff --git a/tools/bpf/bpftool/Documentation/bpftool-map.rst b/tools/bpf/bpftool/Documentation/bpftool-map.rst
> index 5daf3de5c744..e4ed7e701c9e 100644
> --- a/tools/bpf/bpftool/Documentation/bpftool-map.rst
> +++ b/tools/bpf/bpftool/Documentation/bpftool-map.rst
> @@ -120,7 +120,8 @@ bpftool map pin     *MAP*  *FILE*
>      character ('.'), which is reserved for future extensions of *bpffs*.
>  
>  bpftool map event_pipe *MAP* [cpu *N* index *M*]
> -    Read events from a **BPF_MAP_TYPE_PERF_EVENT_ARRAY** map.
> +    Read events from a **BPF_MAP_TYPE_PERF_EVENT_ARRAY** or
> +    **BPF_MAP_TYPE_RINGBUF** map.
>  
>      Install perf rings into a perf event array map and dump output of any
>      **bpf_perf_event_output**\ () call in the kernel. By default read the
> @@ -134,6 +135,17 @@ bpftool map event_pipe *MAP* [cpu *N* index *M*]
>      existing ring.  Any other application will stop receiving events if it
>      installed its rings earlier.
>  
> +    For a ring buffer map, consume records submitted by BPF programs, including
> +    records already queued before the command starts. **cpu** and **index**
> +    are not supported. Each record is printed in full, including embedded zero
> +    bytes. Plain output reports the record size followed by hexadecimal
> +    bytes; JSON output contains **size** and **data** fields, with **data** an
> +    array of byte values. Ring buffer records have no implicit CPU or timestamp.
> +
> +    Consuming a ring buffer advances its shared consumer position, so this
> +    command must not run alongside another consumer of the same map.
> +    **BPF_MAP_TYPE_USER_RINGBUF** maps are not supported.
> +
>  bpftool map peek  *MAP*
>      Peek next value in the queue or stack.
>  
> diff --git a/tools/bpf/bpftool/bash-completion/bpftool b/tools/bpf/bpftool/bash-completion/bpftool
> index 75cbcb512eba..1750b488c9e3 100644
> --- a/tools/bpf/bpftool/bash-completion/bpftool
> +++ b/tools/bpf/bpftool/bash-completion/bpftool
> @@ -878,11 +878,11 @@ _bpftool()
>                              return 0
>                              ;;
>                          id)
> -                            _bpftool_get_map_ids_for_type perf_event_array
> +                            _bpftool_get_map_ids_for_type '"type": "\(perf_event_array\|ringbuf\)"'
>                              return 0
>                              ;;
>                          name)
> -                            _bpftool_get_map_names_for_type perf_event_array
> +                            _bpftool_get_map_names_for_type '"type": "\(perf_event_array\|ringbuf\)"'


I'm not a fan of this change, it doesn't look clean. Let's adjust the
functions to take multiple arguments, instead; see my proposal at the
end of this message.


>                              return 0
>                              ;;
>                          cpu)
> diff --git a/tools/bpf/bpftool/map_perf_ring.c b/tools/bpf/bpftool/map_perf_ring.c
> index bcb767e2d673..7d555331f443 100644
> --- a/tools/bpf/bpftool/map_perf_ring.c
> +++ b/tools/bpf/bpftool/map_perf_ring.c
> @@ -27,7 +27,7 @@
>  
>  #define MMAP_PAGE_CNT	16
>  
> -static volatile bool stop;
> +static volatile sig_atomic_t stop;
>  
>  struct perf_event_sample {
>  	struct perf_event_header header;
> @@ -44,7 +44,6 @@ struct perf_event_lost {
>  
>  static void int_exit(int signo)
>  {
> -	fprintf(stderr, "Stopping...\n");
>  	stop = true;
>  }
>  
> @@ -107,6 +106,27 @@ print_bpf_output(void *private_data, int cpu, struct perf_event_header *event)
>  	return LIBBPF_PERF_EVENT_CONT;
>  }
>  
> +static int print_ringbuf_output(void *ctx, void *data, size_t size)
> +{
> +	if (json_output) {
> +		jsonw_start_object(json_wtr);
> +		jsonw_uint_field(json_wtr, "size", size);
> +		jsonw_name(json_wtr, "data");
> +		print_data_json(data, size);
> +		jsonw_end_object(json_wtr);
> +	} else {
> +		printf("== size: %zu =====\n", size);
> +		fprint_hex(stdout, data, size, " ");
> +		printf("\n");
> +	}
> +
> +	if (fflush(stdout))
> +		return errno ? -errno : -EIO;
> +
> +	/* A producer can keep poll() busy even after a signal arrives. */
> +	return stop ? -EINTR : 0;
> +}
> +
>  int do_event_pipe(int argc, char **argv)
>  {
>  	struct perf_event_attr perf_attr = {
> @@ -123,18 +143,26 @@ int do_event_pipe(int argc, char **argv)
>  		.cpu = -1,
>  		.idx = -1,
>  	};
> -	struct perf_buffer *pb;
> +	struct perf_buffer *pb = NULL;
> +	struct ring_buffer *rb = NULL;
>  	__u32 map_info_len;
>  	int err, map_fd;
>  
> +	stop = false;
>  	map_info_len = sizeof(map_info);
>  	map_fd = map_parse_fd_and_info(&argc, &argv, &map_info, &map_info_len,
>  				       0);
>  	if (map_fd < 0)
>  		return -1;
>  
> -	if (map_info.type != BPF_MAP_TYPE_PERF_EVENT_ARRAY) {
> -		p_err("map is not a perf event array");
> +	if (map_info.type != BPF_MAP_TYPE_PERF_EVENT_ARRAY &&
> +	    map_info.type != BPF_MAP_TYPE_RINGBUF) {
> +		p_err("map is not a perf event array or ring buffer");
> +		goto err_close_map;
> +	}
> +
> +	if (map_info.type == BPF_MAP_TYPE_RINGBUF && argc) {
> +		p_err("ring buffer maps do not support cpu or index arguments");


Maybe restrict this message for when we find explicitly "cpu" or "index"
as argument, and leave the regular parsing error for other argument
names? If the user adds a trailing "foobar" argument, it's strange to
get an error message saying "cpu" or "index" are not supported.


>  		goto err_close_map;
>  	}
>  
> @@ -184,15 +212,24 @@ int do_event_pipe(int argc, char **argv)
>  		ctx.idx = 0;
>  	}
>  
> -	opts.cpu_cnt = ctx.all_cpus ? 0 : 1;
> -	opts.cpus = &ctx.cpu;
> -	opts.map_keys = &ctx.idx;
> -	pb = perf_buffer__new_raw(map_fd, MMAP_PAGE_CNT, &perf_attr,
> -				  print_bpf_output, &ctx, &opts);
> -	if (!pb) {
> -		p_err("failed to create perf buffer: %s (%d)",
> -		      strerror(errno), errno);
> -		goto err_close_map;
> +	if (map_info.type == BPF_MAP_TYPE_RINGBUF) {
> +		rb = ring_buffer__new(map_fd, print_ringbuf_output, NULL, NULL);
> +		if (!rb) {
> +			p_err("failed to create ring buffer: %s (%d)",
> +			      strerror(errno), errno);
> +			goto err_close_map;
> +		}
> +	} else {
> +		opts.cpu_cnt = ctx.all_cpus ? 0 : 1;
> +		opts.cpus = &ctx.cpu;
> +		opts.map_keys = &ctx.idx;
> +		pb = perf_buffer__new_raw(map_fd, MMAP_PAGE_CNT, &perf_attr,
> +					  print_bpf_output, &ctx, &opts);
> +		if (!pb) {
> +			p_err("failed to create perf buffer: %s (%d)",
> +			      strerror(errno), errno);
> +			goto err_close_map;
> +		}
>  	}
>  
>  	signal(SIGINT, int_exit);
> @@ -202,25 +239,33 @@ int do_event_pipe(int argc, char **argv)
>  	if (json_output)
>  		jsonw_start_array(json_wtr);
>  
> +	err = 0;
>  	while (!stop) {
> -		err = perf_buffer__poll(pb, 200);
> +		err = rb ? ring_buffer__poll(rb, 200) : perf_buffer__poll(pb, 200);
>  		if (err < 0 && err != -EINTR) {
> -			p_err("perf buffer polling failed: %s (%d)",
> -			      strerror(errno), errno);
> -			goto err_close_pb;
> +			fprintf(stderr, "Error: %s buffer polling failed: %s (%d)\n",
> +				rb ? "ring" : "perf", strerror(-err), -err);

Please use p_err() instead of fprintf().

> +			break;
>  		}
> +		err = 0;
>  	}
>  
> +	if (stop)
> +		fprintf(stderr, "Stopping...\n");
>  	if (json_output)
>  		jsonw_end_array(json_wtr);
> +	if (fflush(stdout)) {
> +		fprintf(stderr, "Error: failed to write events: %s\n", strerror(errno));

p_err("...") rather than fprintf(stderr, "Error: ... \n").

> +		err = -1;
> +	}
>  
> +	ring_buffer__free(rb);
>  	perf_buffer__free(pb);
> +	/* Both buffer managers borrow map_fd. */


Nit: Let's drop this comment.


>  	close(map_fd);
>  
> -	return 0;
> +	return err < 0 ? -1 : 0;
>  
> -err_close_pb:
> -	perf_buffer__free(pb);
>  err_close_map:
>  	close(map_fd);
>  	return -1;


bash completion proposal below:
------

diff --git a/tools/bpf/bpftool/bash-completion/bpftool b/tools/bpf/bpftool/bash-completion/bpftool
index 1750b488c9e3..e4d826a22457 100644
--- a/tools/bpf/bpftool/bash-completion/bpftool
+++ b/tools/bpf/bpftool/bash-completion/bpftool
@@ -50,12 +50,20 @@ _bpftool_get_map_ids()
         command sed -n 's/.*"id": \(.*\),$/\1/p' )" -- "$cur" ) )
 }
 
-# Takes map type and adds matching map ids to the list of suggestions.
-_bpftool_get_map_ids_for_type()
+# Takes one or more map types and prints an extended regular expression
+# matching the "type" field of any of them in bpftool's JSON output.
+_bpftool_build_type_pattern()
 {
-    local type="$1"
+    local IFS='|'
+    printf '"type": "(%s)"\n' "$*"
+}
+
+# Takes map types and adds matching map ids to the list of suggestions.
+_bpftool_get_map_ids_for_types()
+{
+    local types=$(_bpftool_build_type_pattern "$@")
     COMPREPLY+=( $( compgen -W "$( bpftool -jp map  2>&1 | \
-        command grep -C2 "$type" | \
+        command grep -C2 -E "$types" | \
         command sed -n 's/.*"id": \(.*\),$/\1/p' )" -- "$cur" ) )
 }
 
@@ -65,12 +73,12 @@ _bpftool_get_map_names()
         command sed -n 's/.*"name": \(.*\),$/\1/p' )" -- "$cur" ) )
 }
 
-# Takes map type and adds matching map names to the list of suggestions.
-_bpftool_get_map_names_for_type()
+# Takes map types and adds matching map names to the list of suggestions.
+_bpftool_get_map_names_for_types()
 {
-    local type="$1"
+    local types=$(_bpftool_build_type_pattern "$@")
     COMPREPLY+=( $( compgen -W "$( bpftool -jp map  2>&1 | \
-        command grep -C2 "$type" | \
+        command grep -C2 -E "$types" | \
         command sed -n 's/.*"name": \(.*\),$/\1/p' )" -- "$cur" ) )
 }
 
@@ -177,10 +185,10 @@ _bpftool_map_update_get_id()
     if [[ $value -eq 0 ]]; then
         case "$command" in
             push)
-                _bpftool_get_map_ids_for_type stack
+                _bpftool_get_map_ids_for_types stack
                 ;;
             enqueue)
-                _bpftool_get_map_ids_for_type queue
+                _bpftool_get_map_ids_for_types queue
                 ;;
             *)
                 _bpftool_get_map_ids
@@ -223,10 +231,10 @@ _bpftool_map_update_get_name()
     if [[ $value -eq 0 ]]; then
         case "$command" in
             push)
-                _bpftool_get_map_names_for_type stack
+                _bpftool_get_map_names_for_types stack
                 ;;
             enqueue)
-                _bpftool_get_map_names_for_type queue
+                _bpftool_get_map_names_for_types queue
                 ;;
             *)
                 _bpftool_get_map_names
@@ -617,10 +625,10 @@ _bpftool()
                             COMPREPLY=( $( compgen -W "$STRUCT_OPS_TYPE" -- "$cur" ) )
                             ;;
                         id)
-                            _bpftool_get_map_ids_for_type struct_ops
+                            _bpftool_get_map_ids_for_types struct_ops
                             ;;
                         name)
-                            _bpftool_get_map_names_for_type struct_ops
+                            _bpftool_get_map_names_for_types struct_ops
                             ;;
                     esac
                     return 0
@@ -679,14 +687,13 @@ _bpftool()
                         id)
                             case "$command" in
                                 peek)
-                                    _bpftool_get_map_ids_for_type stack
-                                    _bpftool_get_map_ids_for_type queue
+                                    _bpftool_get_map_ids_for_types stack queue
                                     ;;
                                 pop)
-                                    _bpftool_get_map_ids_for_type stack
+                                    _bpftool_get_map_ids_for_types stack
                                     ;;
                                 dequeue)
-                                    _bpftool_get_map_ids_for_type queue
+                                    _bpftool_get_map_ids_for_types queue
                                     ;;
                                 *)
                                     _bpftool_get_map_ids
@@ -697,14 +704,13 @@ _bpftool()
                         name)
                             case "$command" in
                                 peek)
-                                    _bpftool_get_map_names_for_type stack
-                                    _bpftool_get_map_names_for_type queue
+                                    _bpftool_get_map_names_for_types stack queue
                                     ;;
                                 pop)
-                                    _bpftool_get_map_names_for_type stack
+                                    _bpftool_get_map_names_for_types stack
                                     ;;
                                 dequeue)
-                                    _bpftool_get_map_names_for_type queue
+                                    _bpftool_get_map_names_for_types queue
                                     ;;
                                 *)
                                     _bpftool_get_map_names
@@ -878,11 +884,11 @@ _bpftool()
                             return 0
                             ;;
                         id)
-                            _bpftool_get_map_ids_for_type '"type": "\(perf_event_array\|ringbuf\)"'
+                            _bpftool_get_map_ids_for_types perf_event_array ringbuf
                             return 0
                             ;;
                         name)
-                            _bpftool_get_map_names_for_type '"type": "\(perf_event_array\|ringbuf\)"'
+                            _bpftool_get_map_names_for_types perf_event_array ringbuf
                             return 0
                             ;;
                         cpu)


