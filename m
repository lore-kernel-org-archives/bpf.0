Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1DAD322A1F
	for <bpf@vger.kernel.org>; Mon, 23 Feb 2026 18:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771871983; cv=none; b=H0RVl/5tZRqHHhejmAGcHrHbXRPYTbADY46kenC3EDA0oYgyS9AgZyAWwlKhX5h/dIG8z7g7lFCEI9/+mY++K6kv488lkaiBwM6YqqgueU80s6TeSR6yeYGKHT22irZJ6Yu5wg4Q3W031e+T8rKAGnho5bkJ3ikhx0Gy+SDew8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771871983; c=relaxed/simple;
	bh=rOT3KruEJTntsL0slA3YsIoA9Iqxla2icAfxp/DbyhE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZnC+Pyr27w3Qhk/PBWgkhNNF9pRBeUwQHBpMCJICuWKoDugXwIVhlCzhC21FW/VwfBh8Vp1ipn+h5BL7IgGVyRM59O7Mu7RcmOlSrPehykIyZgbjxHp9sAtEJ+2Pr806n+iTj4r23ycqYTS8+K+Z6/a6H0oPFK3//JLJRV+DaTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XiSi1dyg; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XiSi1dyg"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-43638a33157so4364960f8f.1
        for <bpf@vger.kernel.org>; Mon, 23 Feb 2026 10:39:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771871980; x=1772476780; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=nTWoQnyDbdV/d33o2Q61WppgJLAE9f0/kmsV49+io10=;
        b=XiSi1dyg/eB+04lGkwFuNl+mP2NRbULCgAX42Duf8hc/Tn5FXjnVhhGEdj/jWbf7w/
         sszFHjosKzeIt1aWey6S91UL8xZUGeWst6C1bIrxNJ3Ceh9WCTIAGinhwe5Bre+zkpHN
         e2Ej41F6eKqnryOW5ilsf5rlEZ6EsEjkl+1+4JiNk6iTB6DSH09N1e5bOb9adIWw3UKa
         eSw94/cEOdt50A4NvaNjeOh/UaUjesuozOG2a3ocJafuE9qK5kJYjIS4BADclKh84X5q
         l1nCJryew7OtfgM/HKecw+egCUZkvsItXHEIgEl8tCMtNCRE1+mggPVNlU2OGVFiDkbp
         YTSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771871980; x=1772476780;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nTWoQnyDbdV/d33o2Q61WppgJLAE9f0/kmsV49+io10=;
        b=vZ8iHRRrS5TEp1xN+Vz7A1ZJozleEC9JyDizGw7Lji6jKcdtSieKmgqjxLrPAaVlgP
         EB6V5UfUBONVUiuw0iTH9WTeEY7jmSDLic6UEPTvxJeyr/uGTglxklNvekdWjPIbdBRt
         63za1BvoSceKZnqd/pjyzifvWl3ln9yIKeebyp3j99sp65069haFcmuGNgtuf3hBHgbS
         Vh419pvdQKMTPRhT6KpXfZeni/kbFMzYUnpgGTRgKn/nwXaLZJzOezWLeDi6sTVU/Irt
         DBAIVpcQsXGUmZRayQNmFfXlT1O6cuwwBZggbkG6YUT9WmzEJdzKLhd5Y9fHJHM/ta/D
         r/WQ==
X-Forwarded-Encrypted: i=1; AJvYcCUNZDCPLtQtCO5CFt8rKUVwvhEUlJ3QfXXM1pyKKFB1IBKDCsym5ndlAYq/BKYVW5vJPB8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz47txdG3vSi4+m6gPxFPlQeep0i2ERWJWgNeisNRHp5s3tEuDV
	W+Tv5yD0NOqnzgqfqYxpj16m333QWiEbGNvPDfVNYjt/d5HDkAx7egtwTMgXFQ==
X-Gm-Gg: ATEYQzz9f7YlfxlS2RyhbFoxqO6fLw+hENuPMWLr8pwIBHGH43UrgAf5x9AOcIRqScy
	Q33CcmpMjb46rGYkvsjhFUeqDMxH0oyuDDn1Nbzhadpn+DDY9RwlqGpvW/cPDZORWSuKy7v402N
	6vtke82+eMHxGnHCpnc8se3bowRi/zFZfeOzg1i/MpLzyWc+ojQloDQKUrN5GmPNJP/Go3TDkpc
	+5KImvh5zYEhwZjk8/k5LYRI54iFpQeQCYsc23uKDJtEskRbhNJtE80N0Ps1XQIahh1xAcrFhyd
	Zva/XmW0zrRfTxOS30YnzMY0KLKgNvhwsrhDOtexKUfkqu77uTNZU1x4FumJws1b/oHk3tA6Sp6
	rHFSDPu4H01HLx120dBlacDk/EBTSaD0CdSlUpX+1Spm0eVHE7j5uzvNtpF7MATUISlbnxZ/FJS
	b7CgaeH6Rtm6zPMy2Z+gQ=
X-Received: by 2002:a5d:5885:0:b0:436:b87:ce5c with SMTP id ffacd0b85a97d-4396f153bdfmr18393443f8f.20.1771871979653;
        Mon, 23 Feb 2026 10:39:39 -0800 (PST)
Received: from localhost ([2620:10d:c092:600::1:3fd5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43970d3ff1csm19565675f8f.20.2026.02.23.10.39.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 10:39:39 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: Emil Tsalapatis <emil@etsalapatis.com>, bpf@vger.kernel.org,
 ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com,
 kernel-team@meta.com, eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: Re: [PATCH bpf-next v2 2/2] selftests/bpf: Use bpf_program__clone()
 in veristat
In-Reply-To: <DGMJ4DNC556M.16VOPU824MANQ@etsalapatis.com>
References: <20260220-veristat_prepare-v2-0-15bff49022a7@meta.com>
 <20260220-veristat_prepare-v2-2-15bff49022a7@meta.com>
 <DGMJ4DNC556M.16VOPU824MANQ@etsalapatis.com>
Date: Mon, 23 Feb 2026 18:39:37 +0000
Message-ID: <874in7cniu.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Emil Tsalapatis" <emil@etsalapatis.com> writes:

> On Fri Feb 20, 2026 at 2:18 PM EST, Mykyta Yatsenko wrote:
>> From: Mykyta Yatsenko <yatsenko@meta.com>
>>
>> Replace veristat's per-program object re-opening with
>> bpf_program__clone().
>>
>> Previously, veristat opened a separate bpf_object for every program in a
>> multi-program object file, iterated all programs to enable only the
>> target one, and then loaded the entire object.
>>
>> Use bpf_object__prepare() once, then call bpf_program__clone() for each
>> program individually. This lets veristat load programs one at a time
>> from a single prepared object.
>>
>> The caller now owns the returned fd and closes it after collecting stats.
>> Remove the special single-program fast path and the per-file early exit
>> in handle_verif_mode() so all files are always processed.
>>
>> Split fixup_obj() into fixup_obj_maps() for object-wide map fixups that
>> must run before bpf_object__prepare(), and fixup_obj() for per-program
>> fixups (struct_ops masking, freplace type guessing) that run before each
>> bpf_program__clone() call.
>>
>> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
>> ---
>>  tools/testing/selftests/bpf/veristat.c | 104 ++++++++++++++-------------------
>>  1 file changed, 44 insertions(+), 60 deletions(-)
>>
>> diff --git a/tools/testing/selftests/bpf/veristat.c b/tools/testing/selftests/bpf/veristat.c
>> index 1be1e353d40a..7d7eb56e04d0 100644
>> --- a/tools/testing/selftests/bpf/veristat.c
>> +++ b/tools/testing/selftests/bpf/veristat.c
>> @@ -1236,7 +1236,7 @@ static void mask_unrelated_struct_ops_progs(struct bpf_object *obj,
>>  	}
>>  }
>>  
>> -static void fixup_obj(struct bpf_object *obj, struct bpf_program *prog, const char *filename)
>> +static void fixup_obj_maps(struct bpf_object *obj)
>>  {
>>  	struct bpf_map *map;
>>  
>> @@ -1251,15 +1251,23 @@ static void fixup_obj(struct bpf_object *obj, struct bpf_program *prog, const ch
>>  		case BPF_MAP_TYPE_INODE_STORAGE:
>>  		case BPF_MAP_TYPE_CGROUP_STORAGE:
>>  		case BPF_MAP_TYPE_CGRP_STORAGE:
>> -			break;
>>  		case BPF_MAP_TYPE_STRUCT_OPS:
>> -			mask_unrelated_struct_ops_progs(obj, map, prog);
>>  			break;
>>  		default:
>>  			if (bpf_map__max_entries(map) == 0)
>>  				bpf_map__set_max_entries(map, 1);
>>  		}
>>  	}
>> +}
>> +
>> +static void fixup_obj(struct bpf_object *obj, struct bpf_program *prog, const char *filename)
>> +{
>> +	struct bpf_map *map;
>> +
>> +	bpf_object__for_each_map(map, obj) {
>> +		if (bpf_map__type(map) == BPF_MAP_TYPE_STRUCT_OPS)
>> +			mask_unrelated_struct_ops_progs(obj, map, prog);
>> +	}
>>  
>>  	/* SEC(freplace) programs can't be loaded with veristat as is,
>>  	 * but we can try guessing their target program's expected type by
>> @@ -1608,6 +1616,7 @@ static int process_prog(const char *filename, struct bpf_object *obj, struct bpf
>>  	const char *base_filename = basename(strdupa(filename));
>>  	const char *prog_name = bpf_program__name(prog);
>>  	long mem_peak_a, mem_peak_b, mem_peak = -1;
>> +	LIBBPF_OPTS(bpf_prog_load_opts, opts);
>>  	char *buf;
>>  	int buf_sz, log_level;
>>  	struct verif_stats *stats;
>> @@ -1647,9 +1656,6 @@ static int process_prog(const char *filename, struct bpf_object *obj, struct bpf
>>  	}
>>  	verif_log_buf[0] = '\0';
>>  
>> -	bpf_program__set_log_buf(prog, buf, buf_sz);
>> -	bpf_program__set_log_level(prog, log_level);
>> -
>>  	/* increase chances of successful BPF object loading */
>>  	fixup_obj(obj, prog, base_filename);
>>  
>> @@ -1658,15 +1664,21 @@ static int process_prog(const char *filename, struct bpf_object *obj, struct bpf
>>  	if (env.force_reg_invariants)
>>  		bpf_program__set_flags(prog, bpf_program__flags(prog) | BPF_F_TEST_REG_INVARIANTS);
>>  
>> -	err = bpf_object__prepare(obj);
>> -	if (!err) {
>> -		cgroup_err = reset_stat_cgroup();
>> -		mem_peak_a = cgroup_memory_peak();
>> -		err = bpf_object__load(obj);
>> -		mem_peak_b = cgroup_memory_peak();
>> -		if (!cgroup_err && mem_peak_a >= 0 && mem_peak_b >= 0)
>> -			mem_peak = mem_peak_b - mem_peak_a;
>> +	opts.log_buf = buf;
>> +	opts.log_size = buf_sz;
>> +	opts.log_level = log_level;
>> +
>> +	cgroup_err = reset_stat_cgroup();
>> +	mem_peak_a = cgroup_memory_peak();
>> +	fd = bpf_program__clone(prog, &opts);
>> +	if (fd < 0) {
>> +		err = fd;
>> +		fprintf(stderr, "Failed to load program %s %d\n", prog_name, err);
>>  	}
>> +	mem_peak_b = cgroup_memory_peak();
>> +	if (!cgroup_err && mem_peak_a >= 0 && mem_peak_b >= 0)
>> +		mem_peak = mem_peak_b - mem_peak_a;
>> +
>
> AFAICT the meaning of mem_peak changes with this patch, right? Before it was the diff between 
> prepare() and load(), with the patch as it is now it is max(prepare,
> load) since mem_peak_a is reset right above. If we do not automatically
> load OBJ_PREPARED programs (see the review for patch 1/2) we can keep
> the old behavior by storing mem_peak_a after the first prepare and
> reading mem_peak_b after clone+load.
>
I'm not sure if I understand why the meaning of mem_peak changed. Before
it was:
   bpf_object__prepare()
   peak_reset()
   a = mem_peak()
   bpf_object__load();
   mem_peak = mem_peak() - a;

and now:
   bpf_object__prepare()
   ...
   peak_reset()
   a = mem_peak()
   bpf_program__clone();
   mem_peak = mem_peak() - a;

I understand this code is supposed to measure the memory overhead for
the loading a single program.

Could you please elaborate what the issue is? Maybe some example?
>>  	env.progs_processed++;
>>  
>>  	stats->file_name = strdup(base_filename);
>> @@ -1678,7 +1690,6 @@ static int process_prog(const char *filename, struct bpf_object *obj, struct bpf
>>  	stats->stats[MEMORY_PEAK] = mem_peak < 0 ? -1 : mem_peak / (1024 * 1024);
>>  
>>  	memset(&info, 0, info_len);
>> -	fd = bpf_program__fd(prog);
>>  	if (fd > 0 && bpf_prog_get_info_by_fd(fd, &info, &info_len) == 0) {
>>  		stats->stats[JITED_SIZE] = info.jited_prog_len;
>>  		if (env.dump_mode & DUMP_JITED)
>> @@ -1699,7 +1710,8 @@ static int process_prog(const char *filename, struct bpf_object *obj, struct bpf
>>  
>>  	if (verif_log_buf != buf)
>>  		free(buf);
>> -
>> +	if (fd > 0)
>> +		close(fd);
>>  	return 0;
>>  }
>>  
>> @@ -2182,8 +2194,8 @@ static int set_global_vars(struct bpf_object *obj, struct var_preset *presets, i
>>  static int process_obj(const char *filename)
>>  {
>>  	const char *base_filename = basename(strdupa(filename));
>> -	struct bpf_object *obj = NULL, *tobj;
>> -	struct bpf_program *prog, *tprog, *lprog;
>> +	struct bpf_object *obj = NULL;
>> +	struct bpf_program *prog;
>>  	libbpf_print_fn_t old_libbpf_print_fn;
>>  	LIBBPF_OPTS(bpf_object_open_opts, opts);
>>  	int err = 0, prog_cnt = 0;
>> @@ -2222,51 +2234,26 @@ static int process_obj(const char *filename)
>>  	env.files_processed++;
>>  
>>  	bpf_object__for_each_program(prog, obj) {
>> +		bpf_program__set_autoload(prog, true);
>>  		prog_cnt++;
>>  	}
>>  
>> -	if (prog_cnt == 1) {
>> -		prog = bpf_object__next_program(obj, NULL);
>> -		bpf_program__set_autoload(prog, true);
>> -		err = set_global_vars(obj, env.presets, env.npresets);
>> -		if (err) {
>> -			fprintf(stderr, "Failed to set global variables %d\n", err);
>> -			goto cleanup;
>> -		}
>> -		process_prog(filename, obj, prog);
>> +	fixup_obj_maps(obj);
>> +
>> +	err = set_global_vars(obj, env.presets, env.npresets);
>> +	if (err) {
>> +		fprintf(stderr, "Failed to set global variables %d\n", err);
>>  		goto cleanup;
>>  	}
>>  
>> -	bpf_object__for_each_program(prog, obj) {
>> -		const char *prog_name = bpf_program__name(prog);
>> -
>> -		tobj = bpf_object__open_file(filename, &opts);
>> -		if (!tobj) {
>> -			err = -errno;
>> -			fprintf(stderr, "Failed to open '%s': %d\n", filename, err);
>> -			goto cleanup;
>> -		}
>> -
>> -		err = set_global_vars(tobj, env.presets, env.npresets);
>> -		if (err) {
>> -			fprintf(stderr, "Failed to set global variables %d\n", err);
>> -			goto cleanup;
>> -		}
>> -
>> -		lprog = NULL;
>> -		bpf_object__for_each_program(tprog, tobj) {
>> -			const char *tprog_name = bpf_program__name(tprog);
>> -
>> -			if (strcmp(prog_name, tprog_name) == 0) {
>> -				bpf_program__set_autoload(tprog, true);
>> -				lprog = tprog;
>> -			} else {
>> -				bpf_program__set_autoload(tprog, false);
>> -			}
>> -		}
>> +	err = bpf_object__prepare(obj);
>> +	if (err) {
>> +		fprintf(stderr, "Failed to prepare BPF object for loading %d\n", err);
>> +		goto cleanup;
>> +	}
>>  
>> -		process_prog(filename, tobj, lprog);
>> -		bpf_object__close(tobj);
>> +	bpf_object__for_each_program(prog, obj) {
>> +		process_prog(filename, obj, prog);
>>  	}
>>  
>>  cleanup:
>> @@ -3264,17 +3251,14 @@ static int handle_verif_mode(void)
>>  	create_stat_cgroup();
>>  	for (i = 0; i < env.filename_cnt; i++) {
>>  		err = process_obj(env.filenames[i]);
>> -		if (err) {
>> +		if (err)
>>  			fprintf(stderr, "Failed to process '%s': %d\n", env.filenames[i], err);
>> -			goto out;
>> -		}
>
> This means we now do not stop on the first failure - this I assume is
> deliberate since it is an improvement over existing behavior imo, but
> still pointing it out in case it isn't.
>
>>  	}
>>  
>>  	qsort(env.prog_stats, env.prog_stat_cnt, sizeof(*env.prog_stats), cmp_prog_stats);
>>  
>>  	output_prog_stats();
>>  
>> -out:
>>  	destroy_stat_cgroup();
>>  	return err;
>>  }
