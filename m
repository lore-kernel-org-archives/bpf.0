Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D5C334029C
	for <bpf@vger.kernel.org>; Mon, 23 Feb 2026 18:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771872887; cv=none; b=puV7aePpgH+PL+O1aflpxM1IGqkclsKLmIFNfTXdSC1NHQOmk2luGit2pYIvTj50ARKu4/OKh+WTHMJFDrMnbAyvn6a/NsMBRifwIvU11D3kxGIo4bB6hEn1/pEkooW3HYYSYOgkINzTFSrpiQWVxRYeUv3kfFExI1+pZvJkB4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771872887; c=relaxed/simple;
	bh=I400pkuIKrqV/7ZJKCDNk8VkJUfJ4F6OOUYUZk8bx9k=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=KbHCH264TJGaEgbvBwExvDa7swKmRTyt7pchuoKYzfwtvcreteAEMrifedjtMfv5Oig86H/+PKJXIlsudLviy9kFm+/QEtbmGzhmaprFIdhOjEc45WL0ytJ0Ebm6iic/qJGXHmtn7QRybi+BrVXBGFVr6mquOTNTxm08PGIdL3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=a1HvoWTR; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="a1HvoWTR"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-8cb420f7500so470736685a.2
        for <bpf@vger.kernel.org>; Mon, 23 Feb 2026 10:54:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1771872884; x=1772477684; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MKJ5Et66U6w6xNucpu6Q22s7IDRlebwXgTXFW59cKFk=;
        b=a1HvoWTRG3vwOt69/QhHPGjtFAjIWzNEeTZGx6SnUMCpO0VU/xXpEpPHSbGRuJq8an
         PJsnegP+pDjs5CBYBBwlx6VId6vknabnTgsDMWk/R+XNolDgtggk6SdTK5zk695mlCpt
         h7PPSKdS40GK8M2RZxEcLv6L27OgsweDx6qt1yOegA5tCsUjiDMPfwQtuspa4ewXCXFi
         7P8+Can9S85Vt3DYGyecv9wo/57PUVBgOQ2ta5DIb+Px4uE+OBCP6qExssoxep4N0xdv
         8UkVR93agFlS6LYiSv53S8/EcWWMq+TjTEwEP+Z0SHT69d6zVznxDp14oNFyIcrFZaC2
         Hhzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771872884; x=1772477684;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MKJ5Et66U6w6xNucpu6Q22s7IDRlebwXgTXFW59cKFk=;
        b=G+sUArhFP1bwzhQghJd1Xj3T6p6gpVkK/58pXpmUKugvBBkxAOVhBNK1tXG9+oDS22
         dLhO8mKPD+wr7Raz3jpeAkLacWF+rl0+AOFuDJuGdS1M4fSAybgDQzU5lkeRk7hmCsYO
         hDvtbTTJoy+2bn11eYPyD9J1V7G5wQjhzyw5dSl0CJtjSghMzPx1DF8Jg2rLZ+zDTqeQ
         qor9Ujgi9RG9Pu6V6u4m1rIjnnziCaTmc2oHK2urcu0hYePklAKArRtAHVDqn9tWs0nX
         iPy4ZRgW5BwRNoKhU2z/v/iBK1D8yJobOYeeZeuGkTdQf2EgbyHtML0HU35t9uVBfm80
         1iYg==
X-Forwarded-Encrypted: i=1; AJvYcCVWjDd7A0ZtDPSfOrIEyRCOUQpfeMYGFo05xL3VR7Ptoncv1L7ff+aVWZMxgjGIsegsw8c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4E0Ix/yOsgOswCMZLhkleW4bX4s8KpQS13f+f8VE/HyWm/Lsi
	BD5IRVB2x5aGK9DhLOJidnAfpV+7UluMb7H2zZjTUPpAiANeuGVR4vz3fnjwG/L1KbQ=
X-Gm-Gg: AZuq6aIKoXdmPDZL4+JpcEQNXCr9zKwh+A3VLA3rNG3W+xzKa0KjOntgZNe032c1NmQ
	unDERjIO0M+V1pZa4hFRnbl79rB77Dfr44E4cQIM4ssLzdyNsEklm+o9hs8dt1cAXGia7Ud2567
	srsTNcp/t+DtJZnG9H1fggkE7dpiG78jb0omBBa548bIJe4DBQDDBWbPmM4/br4Nunpd+0BaYik
	P1Pmmr/hht2MsLu2nXBvQntKbCLeUnf3GpLZ/auZhg7+ZptL7knzRRP4evDx2nBlD83P2tXCLGk
	xu4j6ES50ZJRdm3vpCSGCzoSTImjR6CGH9gVmxspAcUOologjNOnKQZiSJi3JmaLL6Ib6xfe5/3
	M/4k0SQtaTfxPHLEBJteXndOmdJWuMVKbTYXUJ7ZSItn2lqbMyq3lnmQEnxU2T7nQi861NkpwE7
	RpA3lP0YwxhRzxySS5hhoX5WI=
X-Received: by 2002:a05:620a:489b:b0:8cb:68ed:cc28 with SMTP id af79cd13be357-8cb8c9d1c8bmr1123091385a.11.1771872883904;
        Mon, 23 Feb 2026 10:54:43 -0800 (PST)
Received: from localhost ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cb8d120020sm771529285a.45.2026.02.23.10.54.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Feb 2026 10:54:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 23 Feb 2026 13:54:42 -0500
Message-Id: <DGMKIL113GDG.31MM5NSHVXNAH@etsalapatis.com>
Cc: "Mykyta Yatsenko" <yatsenko@meta.com>
Subject: Re: [PATCH bpf-next v2 2/2] selftests/bpf: Use bpf_program__clone()
 in veristat
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Mykyta Yatsenko" <mykyta.yatsenko5@gmail.com>, <bpf@vger.kernel.org>,
 <ast@kernel.org>, <andrii@kernel.org>, <daniel@iogearbox.net>,
 <kafai@meta.com>, <kernel-team@meta.com>, <eddyz87@gmail.com>
X-Mailer: aerc 0.20.1
References: <20260220-veristat_prepare-v2-0-15bff49022a7@meta.com>
 <20260220-veristat_prepare-v2-2-15bff49022a7@meta.com>
 <DGMJ4DNC556M.16VOPU824MANQ@etsalapatis.com> <874in7cniu.fsf@gmail.com>
In-Reply-To: <874in7cniu.fsf@gmail.com>

On Mon Feb 23, 2026 at 1:39 PM EST, Mykyta Yatsenko wrote:
> "Emil Tsalapatis" <emil@etsalapatis.com> writes:
>
>> On Fri Feb 20, 2026 at 2:18 PM EST, Mykyta Yatsenko wrote:
>>> From: Mykyta Yatsenko <yatsenko@meta.com>
>>>
>>> Replace veristat's per-program object re-opening with
>>> bpf_program__clone().
>>>
>>> Previously, veristat opened a separate bpf_object for every program in =
a
>>> multi-program object file, iterated all programs to enable only the
>>> target one, and then loaded the entire object.
>>>
>>> Use bpf_object__prepare() once, then call bpf_program__clone() for each
>>> program individually. This lets veristat load programs one at a time
>>> from a single prepared object.
>>>
>>> The caller now owns the returned fd and closes it after collecting stat=
s.
>>> Remove the special single-program fast path and the per-file early exit
>>> in handle_verif_mode() so all files are always processed.
>>>
>>> Split fixup_obj() into fixup_obj_maps() for object-wide map fixups that
>>> must run before bpf_object__prepare(), and fixup_obj() for per-program
>>> fixups (struct_ops masking, freplace type guessing) that run before eac=
h
>>> bpf_program__clone() call.
>>>
>>> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
>>> ---
>>>  tools/testing/selftests/bpf/veristat.c | 104 ++++++++++++++-----------=
--------
>>>  1 file changed, 44 insertions(+), 60 deletions(-)
>>>
>>> diff --git a/tools/testing/selftests/bpf/veristat.c b/tools/testing/sel=
ftests/bpf/veristat.c
>>> index 1be1e353d40a..7d7eb56e04d0 100644
>>> --- a/tools/testing/selftests/bpf/veristat.c
>>> +++ b/tools/testing/selftests/bpf/veristat.c
>>> @@ -1236,7 +1236,7 @@ static void mask_unrelated_struct_ops_progs(struc=
t bpf_object *obj,
>>>  	}
>>>  }
>>> =20
>>> -static void fixup_obj(struct bpf_object *obj, struct bpf_program *prog=
, const char *filename)
>>> +static void fixup_obj_maps(struct bpf_object *obj)
>>>  {
>>>  	struct bpf_map *map;
>>> =20
>>> @@ -1251,15 +1251,23 @@ static void fixup_obj(struct bpf_object *obj, s=
truct bpf_program *prog, const ch
>>>  		case BPF_MAP_TYPE_INODE_STORAGE:
>>>  		case BPF_MAP_TYPE_CGROUP_STORAGE:
>>>  		case BPF_MAP_TYPE_CGRP_STORAGE:
>>> -			break;
>>>  		case BPF_MAP_TYPE_STRUCT_OPS:
>>> -			mask_unrelated_struct_ops_progs(obj, map, prog);
>>>  			break;
>>>  		default:
>>>  			if (bpf_map__max_entries(map) =3D=3D 0)
>>>  				bpf_map__set_max_entries(map, 1);
>>>  		}
>>>  	}
>>> +}
>>> +
>>> +static void fixup_obj(struct bpf_object *obj, struct bpf_program *prog=
, const char *filename)
>>> +{
>>> +	struct bpf_map *map;
>>> +
>>> +	bpf_object__for_each_map(map, obj) {
>>> +		if (bpf_map__type(map) =3D=3D BPF_MAP_TYPE_STRUCT_OPS)
>>> +			mask_unrelated_struct_ops_progs(obj, map, prog);
>>> +	}
>>> =20
>>>  	/* SEC(freplace) programs can't be loaded with veristat as is,
>>>  	 * but we can try guessing their target program's expected type by
>>> @@ -1608,6 +1616,7 @@ static int process_prog(const char *filename, str=
uct bpf_object *obj, struct bpf
>>>  	const char *base_filename =3D basename(strdupa(filename));
>>>  	const char *prog_name =3D bpf_program__name(prog);
>>>  	long mem_peak_a, mem_peak_b, mem_peak =3D -1;
>>> +	LIBBPF_OPTS(bpf_prog_load_opts, opts);
>>>  	char *buf;
>>>  	int buf_sz, log_level;
>>>  	struct verif_stats *stats;
>>> @@ -1647,9 +1656,6 @@ static int process_prog(const char *filename, str=
uct bpf_object *obj, struct bpf
>>>  	}
>>>  	verif_log_buf[0] =3D '\0';
>>> =20
>>> -	bpf_program__set_log_buf(prog, buf, buf_sz);
>>> -	bpf_program__set_log_level(prog, log_level);
>>> -
>>>  	/* increase chances of successful BPF object loading */
>>>  	fixup_obj(obj, prog, base_filename);
>>> =20
>>> @@ -1658,15 +1664,21 @@ static int process_prog(const char *filename, s=
truct bpf_object *obj, struct bpf
>>>  	if (env.force_reg_invariants)
>>>  		bpf_program__set_flags(prog, bpf_program__flags(prog) | BPF_F_TEST_R=
EG_INVARIANTS);
>>> =20
>>> -	err =3D bpf_object__prepare(obj);
>>> -	if (!err) {
>>> -		cgroup_err =3D reset_stat_cgroup();
>>> -		mem_peak_a =3D cgroup_memory_peak();
>>> -		err =3D bpf_object__load(obj);
>>> -		mem_peak_b =3D cgroup_memory_peak();
>>> -		if (!cgroup_err && mem_peak_a >=3D 0 && mem_peak_b >=3D 0)
>>> -			mem_peak =3D mem_peak_b - mem_peak_a;
>>> +	opts.log_buf =3D buf;
>>> +	opts.log_size =3D buf_sz;
>>> +	opts.log_level =3D log_level;
>>> +
>>> +	cgroup_err =3D reset_stat_cgroup();
>>> +	mem_peak_a =3D cgroup_memory_peak();
>>> +	fd =3D bpf_program__clone(prog, &opts);
>>> +	if (fd < 0) {
>>> +		err =3D fd;
>>> +		fprintf(stderr, "Failed to load program %s %d\n", prog_name, err);
>>>  	}
>>> +	mem_peak_b =3D cgroup_memory_peak();
>>> +	if (!cgroup_err && mem_peak_a >=3D 0 && mem_peak_b >=3D 0)
>>> +		mem_peak =3D mem_peak_b - mem_peak_a;
>>> +
>>
>> AFAICT the meaning of mem_peak changes with this patch, right? Before it=
 was the diff between=20
>> prepare() and load(), with the patch as it is now it is max(prepare,
>> load) since mem_peak_a is reset right above. If we do not automatically
>> load OBJ_PREPARED programs (see the review for patch 1/2) we can keep
>> the old behavior by storing mem_peak_a after the first prepare and
>> reading mem_peak_b after clone+load.
>>
> I'm not sure if I understand why the meaning of mem_peak changed. Before
> it was:
>    bpf_object__prepare()
>    peak_reset()
>    a =3D mem_peak()
>    bpf_object__load();
>    mem_peak =3D mem_peak() - a;
>
> and now:
>    bpf_object__prepare()
>    ...
>    peak_reset()
>    a =3D mem_peak()
>    bpf_program__clone();
>    mem_peak =3D mem_peak() - a;
>
> I understand this code is supposed to measure the memory overhead for
> the loading a single program.
>
> Could you please elaborate what the issue is? Maybe some example?

You're right, I misread this - behavior is identical. With that:

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

>>>  	env.progs_processed++;
>>> =20
>>>  	stats->file_name =3D strdup(base_filename);
>>> @@ -1678,7 +1690,6 @@ static int process_prog(const char *filename, str=
uct bpf_object *obj, struct bpf
>>>  	stats->stats[MEMORY_PEAK] =3D mem_peak < 0 ? -1 : mem_peak / (1024 * =
1024);
>>> =20
>>>  	memset(&info, 0, info_len);
>>> -	fd =3D bpf_program__fd(prog);
>>>  	if (fd > 0 && bpf_prog_get_info_by_fd(fd, &info, &info_len) =3D=3D 0)=
 {
>>>  		stats->stats[JITED_SIZE] =3D info.jited_prog_len;
>>>  		if (env.dump_mode & DUMP_JITED)
>>> @@ -1699,7 +1710,8 @@ static int process_prog(const char *filename, str=
uct bpf_object *obj, struct bpf
>>> =20
>>>  	if (verif_log_buf !=3D buf)
>>>  		free(buf);
>>> -
>>> +	if (fd > 0)
>>> +		close(fd);
>>>  	return 0;
>>>  }
>>> =20
>>> @@ -2182,8 +2194,8 @@ static int set_global_vars(struct bpf_object *obj=
, struct var_preset *presets, i
>>>  static int process_obj(const char *filename)
>>>  {
>>>  	const char *base_filename =3D basename(strdupa(filename));
>>> -	struct bpf_object *obj =3D NULL, *tobj;
>>> -	struct bpf_program *prog, *tprog, *lprog;
>>> +	struct bpf_object *obj =3D NULL;
>>> +	struct bpf_program *prog;
>>>  	libbpf_print_fn_t old_libbpf_print_fn;
>>>  	LIBBPF_OPTS(bpf_object_open_opts, opts);
>>>  	int err =3D 0, prog_cnt =3D 0;
>>> @@ -2222,51 +2234,26 @@ static int process_obj(const char *filename)
>>>  	env.files_processed++;
>>> =20
>>>  	bpf_object__for_each_program(prog, obj) {
>>> +		bpf_program__set_autoload(prog, true);
>>>  		prog_cnt++;
>>>  	}
>>> =20
>>> -	if (prog_cnt =3D=3D 1) {
>>> -		prog =3D bpf_object__next_program(obj, NULL);
>>> -		bpf_program__set_autoload(prog, true);
>>> -		err =3D set_global_vars(obj, env.presets, env.npresets);
>>> -		if (err) {
>>> -			fprintf(stderr, "Failed to set global variables %d\n", err);
>>> -			goto cleanup;
>>> -		}
>>> -		process_prog(filename, obj, prog);
>>> +	fixup_obj_maps(obj);
>>> +
>>> +	err =3D set_global_vars(obj, env.presets, env.npresets);
>>> +	if (err) {
>>> +		fprintf(stderr, "Failed to set global variables %d\n", err);
>>>  		goto cleanup;
>>>  	}
>>> =20
>>> -	bpf_object__for_each_program(prog, obj) {
>>> -		const char *prog_name =3D bpf_program__name(prog);
>>> -
>>> -		tobj =3D bpf_object__open_file(filename, &opts);
>>> -		if (!tobj) {
>>> -			err =3D -errno;
>>> -			fprintf(stderr, "Failed to open '%s': %d\n", filename, err);
>>> -			goto cleanup;
>>> -		}
>>> -
>>> -		err =3D set_global_vars(tobj, env.presets, env.npresets);
>>> -		if (err) {
>>> -			fprintf(stderr, "Failed to set global variables %d\n", err);
>>> -			goto cleanup;
>>> -		}
>>> -
>>> -		lprog =3D NULL;
>>> -		bpf_object__for_each_program(tprog, tobj) {
>>> -			const char *tprog_name =3D bpf_program__name(tprog);
>>> -
>>> -			if (strcmp(prog_name, tprog_name) =3D=3D 0) {
>>> -				bpf_program__set_autoload(tprog, true);
>>> -				lprog =3D tprog;
>>> -			} else {
>>> -				bpf_program__set_autoload(tprog, false);
>>> -			}
>>> -		}
>>> +	err =3D bpf_object__prepare(obj);
>>> +	if (err) {
>>> +		fprintf(stderr, "Failed to prepare BPF object for loading %d\n", err=
);
>>> +		goto cleanup;
>>> +	}
>>> =20
>>> -		process_prog(filename, tobj, lprog);
>>> -		bpf_object__close(tobj);
>>> +	bpf_object__for_each_program(prog, obj) {
>>> +		process_prog(filename, obj, prog);
>>>  	}
>>> =20
>>>  cleanup:
>>> @@ -3264,17 +3251,14 @@ static int handle_verif_mode(void)
>>>  	create_stat_cgroup();
>>>  	for (i =3D 0; i < env.filename_cnt; i++) {
>>>  		err =3D process_obj(env.filenames[i]);
>>> -		if (err) {
>>> +		if (err)
>>>  			fprintf(stderr, "Failed to process '%s': %d\n", env.filenames[i], e=
rr);
>>> -			goto out;
>>> -		}
>>
>> This means we now do not stop on the first failure - this I assume is
>> deliberate since it is an improvement over existing behavior imo, but
>> still pointing it out in case it isn't.
>>
>>>  	}
>>> =20
>>>  	qsort(env.prog_stats, env.prog_stat_cnt, sizeof(*env.prog_stats), cmp=
_prog_stats);
>>> =20
>>>  	output_prog_stats();
>>> =20
>>> -out:
>>>  	destroy_stat_cgroup();
>>>  	return err;
>>>  }

