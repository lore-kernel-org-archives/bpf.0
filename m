Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0413338932
	for <bpf@vger.kernel.org>; Mon, 23 Feb 2026 17:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771868953; cv=none; b=d6ogU6HQYqHI3EJRNMdxnsNRS6cJW/OVX2Pa7/8uqK4WZ6ycpQNhbWbGsTI0+eW8AxNqiJgt5sV/LjUgnc11VMrjlT8N5XARIIDx9J6Sk/S2Rhu9t1RtHt3reLJaQjByCXpDqIH73EpSkSEG2MEm/WVuuAcSe4oyZPTQ67tuIJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771868953; c=relaxed/simple;
	bh=6qvrwil30/sDuY274MRx8CP+qfGgHuHzqnv7DqaXYzk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=kdQFvO3vNMOg/8VmcN0NOfTyKLm7iHy4Y0u76HPl7GhW+y8V283XoYkqSptsHgSAhXFtLfEG9dLu7rG9roTOxY5RmUqIgj+uEFvzDLgs3M/2cz84mK2a6zfj0MU3GBVMR6nyS4zspUUU0JDVJ3/woVwdKpa7L+wTbc0NMp49Jmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=hN2otxWG; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="hN2otxWG"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-506a321cc53so52194941cf.3
        for <bpf@vger.kernel.org>; Mon, 23 Feb 2026 09:49:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1771868951; x=1772473751; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C1gOFqHchQ4W4WtYiZT688D/v96v1c0lkgtrs02qXnc=;
        b=hN2otxWGF5d6CHeoN9qLjPPkboFdk8JsjBpYdMerr54zN1yU0MJN0m8eAbxVjTcA4u
         NeBs+QQV3zHWNikYiHue+2N0Jfz5LzbvOR3urQt/RXquibxHQ/VG9K0FiZPcQInd/uK2
         bF1Yj/n6jeWXoygZcChR1QBOo4nXTaXppnGExiGYdcinnoBBFn15FBr0F6cpB44ki96P
         nrgnYlOkTPu45ZJxuN6FseIWJEPlPriCLpeHcGATguojAY2ijtqP4sbtBlpU+9QY/7WF
         FJXqRVyk9ESQXTyLENQmQxoJSwBvWTE5diHIUB0ZYJtLyZJ8k0BcQVcfMT/m8wVYJoUY
         FHkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771868951; x=1772473751;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C1gOFqHchQ4W4WtYiZT688D/v96v1c0lkgtrs02qXnc=;
        b=vek0ZVl+XVkLVnbzTyUiVXvCeFalrqaqvR389Qjg5dbdCc3rl2FTzqV3ZCX6OtclN5
         eT4dvjlj5L5QIeUOVFaFA5rK/Ut090Rj1THEndM46zZgm5PmmFU1gCUuKbMQa2jI4XbK
         Q8X99f6Sz8JENhRYLbt4UzrK1P9myk5mZBaqA58VhldnTUdRl9x2kqTgw0uuELR7O4IA
         KDskf7SSfW3zUSWHWp3yNH/Rn9LqEJRn8im42R12hq8+KGdKBdj5PQKybpLEJ1tuMVhF
         8uZIPgEdGjKuqMduEDWYL24VCGvcSVHDW279Muvv6qUy90q/FJQ+XRjuxgRYSlEhi1Ph
         iUQA==
X-Forwarded-Encrypted: i=1; AJvYcCW1d4prE/aRKHwrxbQCrvEdpFnQdghEjlP4B7pkXphWjt3bu4iI7iCNsUA/aic+OglQBl4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKHHRW+UNQtwWEM7qEf4T5GK23jYTdCD7vjIq/3gxPz1s86IU4
	wV30dPp07VkHFmgxaF52m5vMixxXwaDYBDcXApGp4gmiyB8lHMB7unzYLAjDk/BIIxs=
X-Gm-Gg: AZuq6aItyZf33XivchGnRNmk/I06g/CgiadmRBtD8sw/1hm2fzujKM8+viQsoDo86Bj
	1DliUS0cPePOTU+sRCpnQpHGayuR5ZqdAhZzhwYzBo7yLLfzEhIgUtSXmKkDuAy7/MdZ+PwQTr5
	RSsLqHFr8i4GVdrR9PgobXlvse9QXbzsQx5cQxbaWk7+DdfTKWRpt4wHxML+PTHWzaMzPEJOy/+
	Rkk+gTdiZkWMxiMZ4907nrc/h98f65XmdzsiIO3wd+5pq+UzFBLxYEwSEjBcTJyD2EoLuyZYmFr
	RDw+Ln1wjSsHtZsggZv2yQfQM84AtKJsoYfc3h+unnBHqRdzeUq/lwuQ0hjpYTUXhhMFdhf7fag
	gKHhExWcanxgwq0v8LvsspKokdHbvUV5Vrx7FgK6En8ysPBjqjqyQc/fQCWtp3IzgJFw0NM8ENa
	c/knH7M0lAuud1jN2eIK53pds=
X-Received: by 2002:ac8:5f8a:0:b0:501:47c4:a4a3 with SMTP id d75a77b69052e-5070bba6964mr120393711cf.10.1771868950546;
        Mon, 23 Feb 2026 09:49:10 -0800 (PST)
Received: from localhost ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8997e6341c4sm73580236d6.35.2026.02.23.09.49.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Feb 2026 09:49:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 23 Feb 2026 12:49:08 -0500
Message-Id: <DGMJ4DNC556M.16VOPU824MANQ@etsalapatis.com>
Subject: Re: [PATCH bpf-next v2 2/2] selftests/bpf: Use bpf_program__clone()
 in veristat
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Mykyta Yatsenko" <mykyta.yatsenko5@gmail.com>, <bpf@vger.kernel.org>,
 <ast@kernel.org>, <andrii@kernel.org>, <daniel@iogearbox.net>,
 <kafai@meta.com>, <kernel-team@meta.com>, <eddyz87@gmail.com>
Cc: "Mykyta Yatsenko" <yatsenko@meta.com>
X-Mailer: aerc 0.20.1
References: <20260220-veristat_prepare-v2-0-15bff49022a7@meta.com>
 <20260220-veristat_prepare-v2-2-15bff49022a7@meta.com>
In-Reply-To: <20260220-veristat_prepare-v2-2-15bff49022a7@meta.com>

On Fri Feb 20, 2026 at 2:18 PM EST, Mykyta Yatsenko wrote:
> From: Mykyta Yatsenko <yatsenko@meta.com>
>
> Replace veristat's per-program object re-opening with
> bpf_program__clone().
>
> Previously, veristat opened a separate bpf_object for every program in a
> multi-program object file, iterated all programs to enable only the
> target one, and then loaded the entire object.
>
> Use bpf_object__prepare() once, then call bpf_program__clone() for each
> program individually. This lets veristat load programs one at a time
> from a single prepared object.
>
> The caller now owns the returned fd and closes it after collecting stats.
> Remove the special single-program fast path and the per-file early exit
> in handle_verif_mode() so all files are always processed.
>
> Split fixup_obj() into fixup_obj_maps() for object-wide map fixups that
> must run before bpf_object__prepare(), and fixup_obj() for per-program
> fixups (struct_ops masking, freplace type guessing) that run before each
> bpf_program__clone() call.
>
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---
>  tools/testing/selftests/bpf/veristat.c | 104 ++++++++++++++-------------=
------
>  1 file changed, 44 insertions(+), 60 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/veristat.c b/tools/testing/selft=
ests/bpf/veristat.c
> index 1be1e353d40a..7d7eb56e04d0 100644
> --- a/tools/testing/selftests/bpf/veristat.c
> +++ b/tools/testing/selftests/bpf/veristat.c
> @@ -1236,7 +1236,7 @@ static void mask_unrelated_struct_ops_progs(struct =
bpf_object *obj,
>  	}
>  }
> =20
> -static void fixup_obj(struct bpf_object *obj, struct bpf_program *prog, =
const char *filename)
> +static void fixup_obj_maps(struct bpf_object *obj)
>  {
>  	struct bpf_map *map;
> =20
> @@ -1251,15 +1251,23 @@ static void fixup_obj(struct bpf_object *obj, str=
uct bpf_program *prog, const ch
>  		case BPF_MAP_TYPE_INODE_STORAGE:
>  		case BPF_MAP_TYPE_CGROUP_STORAGE:
>  		case BPF_MAP_TYPE_CGRP_STORAGE:
> -			break;
>  		case BPF_MAP_TYPE_STRUCT_OPS:
> -			mask_unrelated_struct_ops_progs(obj, map, prog);
>  			break;
>  		default:
>  			if (bpf_map__max_entries(map) =3D=3D 0)
>  				bpf_map__set_max_entries(map, 1);
>  		}
>  	}
> +}
> +
> +static void fixup_obj(struct bpf_object *obj, struct bpf_program *prog, =
const char *filename)
> +{
> +	struct bpf_map *map;
> +
> +	bpf_object__for_each_map(map, obj) {
> +		if (bpf_map__type(map) =3D=3D BPF_MAP_TYPE_STRUCT_OPS)
> +			mask_unrelated_struct_ops_progs(obj, map, prog);
> +	}
> =20
>  	/* SEC(freplace) programs can't be loaded with veristat as is,
>  	 * but we can try guessing their target program's expected type by
> @@ -1608,6 +1616,7 @@ static int process_prog(const char *filename, struc=
t bpf_object *obj, struct bpf
>  	const char *base_filename =3D basename(strdupa(filename));
>  	const char *prog_name =3D bpf_program__name(prog);
>  	long mem_peak_a, mem_peak_b, mem_peak =3D -1;
> +	LIBBPF_OPTS(bpf_prog_load_opts, opts);
>  	char *buf;
>  	int buf_sz, log_level;
>  	struct verif_stats *stats;
> @@ -1647,9 +1656,6 @@ static int process_prog(const char *filename, struc=
t bpf_object *obj, struct bpf
>  	}
>  	verif_log_buf[0] =3D '\0';
> =20
> -	bpf_program__set_log_buf(prog, buf, buf_sz);
> -	bpf_program__set_log_level(prog, log_level);
> -
>  	/* increase chances of successful BPF object loading */
>  	fixup_obj(obj, prog, base_filename);
> =20
> @@ -1658,15 +1664,21 @@ static int process_prog(const char *filename, str=
uct bpf_object *obj, struct bpf
>  	if (env.force_reg_invariants)
>  		bpf_program__set_flags(prog, bpf_program__flags(prog) | BPF_F_TEST_REG=
_INVARIANTS);
> =20
> -	err =3D bpf_object__prepare(obj);
> -	if (!err) {
> -		cgroup_err =3D reset_stat_cgroup();
> -		mem_peak_a =3D cgroup_memory_peak();
> -		err =3D bpf_object__load(obj);
> -		mem_peak_b =3D cgroup_memory_peak();
> -		if (!cgroup_err && mem_peak_a >=3D 0 && mem_peak_b >=3D 0)
> -			mem_peak =3D mem_peak_b - mem_peak_a;
> +	opts.log_buf =3D buf;
> +	opts.log_size =3D buf_sz;
> +	opts.log_level =3D log_level;
> +
> +	cgroup_err =3D reset_stat_cgroup();
> +	mem_peak_a =3D cgroup_memory_peak();
> +	fd =3D bpf_program__clone(prog, &opts);
> +	if (fd < 0) {
> +		err =3D fd;
> +		fprintf(stderr, "Failed to load program %s %d\n", prog_name, err);
>  	}
> +	mem_peak_b =3D cgroup_memory_peak();
> +	if (!cgroup_err && mem_peak_a >=3D 0 && mem_peak_b >=3D 0)
> +		mem_peak =3D mem_peak_b - mem_peak_a;
> +

AFAICT the meaning of mem_peak changes with this patch, right? Before it wa=
s the diff between=20
prepare() and load(), with the patch as it is now it is max(prepare,
load) since mem_peak_a is reset right above. If we do not automatically
load OBJ_PREPARED programs (see the review for patch 1/2) we can keep
the old behavior by storing mem_peak_a after the first prepare and
reading mem_peak_b after clone+load.

>  	env.progs_processed++;
> =20
>  	stats->file_name =3D strdup(base_filename);
> @@ -1678,7 +1690,6 @@ static int process_prog(const char *filename, struc=
t bpf_object *obj, struct bpf
>  	stats->stats[MEMORY_PEAK] =3D mem_peak < 0 ? -1 : mem_peak / (1024 * 10=
24);
> =20
>  	memset(&info, 0, info_len);
> -	fd =3D bpf_program__fd(prog);
>  	if (fd > 0 && bpf_prog_get_info_by_fd(fd, &info, &info_len) =3D=3D 0) {
>  		stats->stats[JITED_SIZE] =3D info.jited_prog_len;
>  		if (env.dump_mode & DUMP_JITED)
> @@ -1699,7 +1710,8 @@ static int process_prog(const char *filename, struc=
t bpf_object *obj, struct bpf
> =20
>  	if (verif_log_buf !=3D buf)
>  		free(buf);
> -
> +	if (fd > 0)
> +		close(fd);
>  	return 0;
>  }
> =20
> @@ -2182,8 +2194,8 @@ static int set_global_vars(struct bpf_object *obj, =
struct var_preset *presets, i
>  static int process_obj(const char *filename)
>  {
>  	const char *base_filename =3D basename(strdupa(filename));
> -	struct bpf_object *obj =3D NULL, *tobj;
> -	struct bpf_program *prog, *tprog, *lprog;
> +	struct bpf_object *obj =3D NULL;
> +	struct bpf_program *prog;
>  	libbpf_print_fn_t old_libbpf_print_fn;
>  	LIBBPF_OPTS(bpf_object_open_opts, opts);
>  	int err =3D 0, prog_cnt =3D 0;
> @@ -2222,51 +2234,26 @@ static int process_obj(const char *filename)
>  	env.files_processed++;
> =20
>  	bpf_object__for_each_program(prog, obj) {
> +		bpf_program__set_autoload(prog, true);
>  		prog_cnt++;
>  	}
> =20
> -	if (prog_cnt =3D=3D 1) {
> -		prog =3D bpf_object__next_program(obj, NULL);
> -		bpf_program__set_autoload(prog, true);
> -		err =3D set_global_vars(obj, env.presets, env.npresets);
> -		if (err) {
> -			fprintf(stderr, "Failed to set global variables %d\n", err);
> -			goto cleanup;
> -		}
> -		process_prog(filename, obj, prog);
> +	fixup_obj_maps(obj);
> +
> +	err =3D set_global_vars(obj, env.presets, env.npresets);
> +	if (err) {
> +		fprintf(stderr, "Failed to set global variables %d\n", err);
>  		goto cleanup;
>  	}
> =20
> -	bpf_object__for_each_program(prog, obj) {
> -		const char *prog_name =3D bpf_program__name(prog);
> -
> -		tobj =3D bpf_object__open_file(filename, &opts);
> -		if (!tobj) {
> -			err =3D -errno;
> -			fprintf(stderr, "Failed to open '%s': %d\n", filename, err);
> -			goto cleanup;
> -		}
> -
> -		err =3D set_global_vars(tobj, env.presets, env.npresets);
> -		if (err) {
> -			fprintf(stderr, "Failed to set global variables %d\n", err);
> -			goto cleanup;
> -		}
> -
> -		lprog =3D NULL;
> -		bpf_object__for_each_program(tprog, tobj) {
> -			const char *tprog_name =3D bpf_program__name(tprog);
> -
> -			if (strcmp(prog_name, tprog_name) =3D=3D 0) {
> -				bpf_program__set_autoload(tprog, true);
> -				lprog =3D tprog;
> -			} else {
> -				bpf_program__set_autoload(tprog, false);
> -			}
> -		}
> +	err =3D bpf_object__prepare(obj);
> +	if (err) {
> +		fprintf(stderr, "Failed to prepare BPF object for loading %d\n", err);
> +		goto cleanup;
> +	}
> =20
> -		process_prog(filename, tobj, lprog);
> -		bpf_object__close(tobj);
> +	bpf_object__for_each_program(prog, obj) {
> +		process_prog(filename, obj, prog);
>  	}
> =20
>  cleanup:
> @@ -3264,17 +3251,14 @@ static int handle_verif_mode(void)
>  	create_stat_cgroup();
>  	for (i =3D 0; i < env.filename_cnt; i++) {
>  		err =3D process_obj(env.filenames[i]);
> -		if (err) {
> +		if (err)
>  			fprintf(stderr, "Failed to process '%s': %d\n", env.filenames[i], err=
);
> -			goto out;
> -		}

This means we now do not stop on the first failure - this I assume is
deliberate since it is an improvement over existing behavior imo, but
still pointing it out in case it isn't.

>  	}
> =20
>  	qsort(env.prog_stats, env.prog_stat_cnt, sizeof(*env.prog_stats), cmp_p=
rog_stats);
> =20
>  	output_prog_stats();
> =20
> -out:
>  	destroy_stat_cgroup();
>  	return err;
>  }

