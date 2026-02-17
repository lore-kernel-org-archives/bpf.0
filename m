Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2DE12877DC
	for <bpf@vger.kernel.org>; Tue, 17 Feb 2026 19:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771357578; cv=none; b=oLMXLxKF4m00y5rep1JQeJG8vSSNBEUQG4tOCy+jBSFe13GZfwIa2vrCba/6Ks2aysNvyLBUGXmIakpFr+uz5Db670R2a8wCIdz8Daud6rua6W0sfzAzaj7G/tMlr8Ro28omeg8crsQAMWK9faodS/Rq87/Y74ON87XUNdEXqZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771357578; c=relaxed/simple;
	bh=NrBQs6fdr/Hm5CFw5TEx8GU0JhOG/yNSzkItILVHoSI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=GJd/3guJxJWh3fIeCBnxQr8MoeetEXyrsozzxnXsg1JE5bfBk4MbwYTiLSgPzsXZmXzlbTaa95wEgIVZwycSJSotCd7CyrBtLLmmESJKqraAUcBfp8FLMoPZy5FnLCMNLE3/nmyql4L1CCCJcfsd+hH2HDVvglDcpm+2EcQ+p58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=FVpbGBhY; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="FVpbGBhY"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-8cb38e6d164so630479085a.3
        for <bpf@vger.kernel.org>; Tue, 17 Feb 2026 11:46:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1771357575; x=1771962375; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RxaB6Y0161htjmR/qRGxc7x7hmJDw7wPCFIHiuCywTk=;
        b=FVpbGBhYq5YNMeDKgw5pwYYUU3U1UeZmM4lRZGY59p46cLcy/0c5d3VS30i5+odHMb
         DCIHxUVZsAoBejv//qz9XDEbrQGKzQc3BosO/3YJWjJb0v932+5dJYvA8ri7MeWL5Jzq
         GflAgUUfWeIHL57aIMHMUoWWO8uYxvz5RQzI5ImrBeUal+zixybObBKt1B01aQVGqmp6
         iidhlHNsCn+YhkN57vwJ4pvYcJ49I+zC6M/4lJwsdR7gGkO7cYLX5PGLCgUQuzeJI+QD
         NRYAAwr1AhQ0+x2lYd7rJ3JynsPix+7Va+lSW33vCbWPdXotKTx9t0frhzxjdsgSQbAs
         ajwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771357575; x=1771962375;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RxaB6Y0161htjmR/qRGxc7x7hmJDw7wPCFIHiuCywTk=;
        b=kSS2z86jN5ct8rmWuRSAxsv9UP9zukPwBURbXQnwrGTzZYC4rHYkEyvvJnrRXdTdgA
         tkmZuu5tdF1NJGiG/j4mfrY57LhdEeQFnCBs7+0zlrtEUTwuouqx4UWSlkPdxz5FDNnu
         xQa8/UV/gw3pkxEORDukWqwB022Cu8EW988jupG+2DaQFMyvyTxkNy4PbwqNW3pNVg4N
         epsqEkqrNeOOtN6ob69/+t9RMHOm5OGQW/Wh614zjA3oucI8i70/QI9CAAVhLzZRwzUZ
         Hy8qJOO9KWA2NEnNmMSrZuKUFh5wxS5ccEB7ePpr9CymXj54gZcDCZSFCo0KqPQmWo5O
         GITw==
X-Gm-Message-State: AOJu0YxKhX0SjL+9lmuRZ1Pf1sFmvu3j7moPS7geHFVbT7+kHCSPAii2
	mFiFl8qCW284BCKvC+DweEltVHt0vGVkObJBW5AJg28wAjhZJYrmtGI5APH7GHDGbmeXMdkYw/e
	WZJ9BD8w=
X-Gm-Gg: AZuq6aLyE8ciIxB0ozXF+kMg+sEMM3UMl4/YcjruZxGifDS3gXoAca+MMraRJp4NPAD
	jBYdpMKZBvhPhhup5fR7Q20BDmmMZW90vBC3DyO8bybbtmp4s+ZMgOdhz+vI92FZN5YHIK8Bi4k
	z/HNxlRWuMcr/zamy/02U0IW20F3vUhtilJuZWYRDGlQrUSbnnoA/D83/JdpoGsTKYYfazf0l0I
	CDZ/0BkrLvQPXRvZ5MjAutIh7LzM8aoreLzQctCzcBh/hOhXP/DSnXyyvnNA5TQqmMf5i7SvROr
	G4Qku/LLdTdyZBCfWW5I9rZot/5ayg/MwzbCTHoXnL24RdA43SM9J6IkNZ+MyE6foaDoNetDmgG
	YDPfueWihA1ayt6pDW/tuu+u9xq/L7/SKU4aa21SDHwJKSs5V1eu5q6YvPF8iQdH1xZJoHz32B/
	y0Mb2pHPY/ospxs2NO3QJ5Amc=
X-Received: by 2002:a05:620a:4586:b0:8ca:2cf9:81a0 with SMTP id af79cd13be357-8cb4c0147e0mr1614368485a.51.1771357575549;
        Tue, 17 Feb 2026 11:46:15 -0800 (PST)
Received: from localhost ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cb2b1f5669sm1622837385a.34.2026.02.17.11.46.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Feb 2026 11:46:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 17 Feb 2026 14:46:14 -0500
Message-Id: <DGHHUROFGUVL.1ADAK5BHSHCLP@etsalapatis.com>
Cc: <bpf@vger.kernel.org>, <ast@kernel.org>, <andrii@kernel.org>,
 <daniel@iogearbox.net>, <john.fastabend@gmail.com>, <memxor@gmail.com>
Subject: Re: [PATCH bpf v2 2/2] libbpf: Delay feature gate check until
 object prepare time
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Andrii Nakryiko" <andrii.nakryiko@gmail.com>
X-Mailer: aerc 0.20.1
References: <20260214021014.15670-1-emil@etsalapatis.com>
 <20260214021014.15670-3-emil@etsalapatis.com>
 <CAEf4BzYVWzQJ5p2ryGZGj-s6BfxS+qrKyKCS6JrMbVJZGd5KTQ@mail.gmail.com>
In-Reply-To: <CAEf4BzYVWzQJ5p2ryGZGj-s6BfxS+qrKyKCS6JrMbVJZGd5KTQ@mail.gmail.com>

On Tue Feb 17, 2026 at 2:03 PM EST, Andrii Nakryiko wrote:
> On Fri, Feb 13, 2026 at 6:11=E2=80=AFPM Emil Tsalapatis <emil@etsalapatis=
.com> wrote:
>>
>> Commit 728ff167910e ("libbpf: Add gating for arena globals relocation fe=
ature")
>> adds a feature gate check that loads a map and BPF program to
>> test the running kernel supports large direct offsets for LDIMM64
>> instructions. This check is currently used to calculate arena symbol
>> offsets during bpf_object__collect_relos, itself called by
>> bpf_object_open.
>>
>> However, the program calling bpf_object_open may not have the permission=
s to
>> load maps and programs. This is the case with the BPF selftests, where
>> bpftool is invoked at compilation time during skeleton generation. This
>> causes errors as the feature gate unexpectedly fails with -EPERM.
>>
>> Avoid this by moving all uses of the FEAT_LDIMM64_FULL_RANGE_OFF feature=
 gate
>> to BPF object preparation time instead.
>>
>> Fixes: 728ff167910e ("libbpf: Add gating for arena globals relocation fe=
ature")
>> Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
>> ---
>>  tools/lib/bpf/libbpf.c | 31 +++++++++++++++++++++++--------
>>  1 file changed, 23 insertions(+), 8 deletions(-)
>>

Hi Andrii,

ack to this and the point for the first patch, two minor followups below.

>
> This works, but see some suggestions for a follow up to contain
> feature-checking a bit better
>
>> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
>> index 93e59ed8d9a1..ff38a9db1b13 100644
>> --- a/tools/lib/bpf/libbpf.c
>> +++ b/tools/lib/bpf/libbpf.c
>> @@ -3009,11 +3009,11 @@ static int init_arena_map_data(struct bpf_object=
 *obj, struct bpf_map *map,
>>         memcpy(obj->arena_data, data, data_sz);
>>         obj->arena_data_sz =3D data_sz;
>>
>> -       /* place globals at the end of the arena (if supported) */
>> -       if (kernel_supports(obj, FEAT_LDIMM64_FULL_RANGE_OFF))
>> -               obj->arena_data_off =3D mmap_sz - data_alloc_sz;
>> -       else
>> -               obj->arena_data_off =3D 0;
>> +       /*
>> +        * possible offset for arena globals into the arena,
>> +        * if supported at load time
>> +        */
>> +       obj->arena_data_off =3D mmap_sz - data_alloc_sz;
>
> I'd keep this obj->arena_data_off at zero at this point (we don't use
> it until prepare step, skeleton also just uses obj->arena_data
> directly without offset during open phase)...
>

Do we even want to keep the assignment? The field should be 0 by default si=
nce=20
we're calloc()'ing the object.

>>
>>         /* make bpf_map__init_value() work for ARENA maps */
>>         map->mmaped =3D obj->arena_data;
>> @@ -4672,7 +4672,7 @@ static int bpf_program__record_reloc(struct bpf_pr=
ogram *prog,
>>                 reloc_desc->type =3D RELO_DATA;
>>                 reloc_desc->insn_idx =3D insn_idx;
>>                 reloc_desc->map_idx =3D obj->arena_map_idx;
>> -               reloc_desc->sym_off =3D sym->st_value + obj->arena_data_=
off;
>> +               reloc_desc->sym_off =3D sym->st_value;
>
> this is good, relos don't need to record this offset...
>
>>
>>                 map =3D &obj->maps[obj->arena_map_idx];
>>                 pr_debug("prog '%s': found arena map %d (%s, sec %d, off=
 %zu) for insn %u\n",
>> @@ -5556,6 +5556,7 @@ bpf_object__create_maps(struct bpf_object *obj)
>>  {
>>         struct bpf_map *map;
>>         unsigned int i, j;
>> +       char *arena_globals;
>>         int err;
>>         bool retried;
>>
>> @@ -5633,7 +5634,15 @@ bpf_object__create_maps(struct bpf_object *obj)
>>                                         return err;
>>                                 }
>>                                 if (obj->arena_data) {
>> -                                       memcpy(map->mmaped + obj->arena_=
data_off, obj->arena_data,
>> +                                       /*
>> +                                        * Only relocate the globals to =
the end of the arena
>> +                                        * if the kernel supports it.
>> +                                        */
>> +                                       arena_globals =3D map->mmaped;
>> +                                       if (kernel_supports(obj, FEAT_LD=
IMM64_FULL_RANGE_OFF))
>> +                                               arena_globals +=3D obj->=
arena_data_off;
>
> and here I'd instead set arena_data_off to its final value (zero or
> proper offset), something like
>
> if (kernel_supports(obj, FEAT_LDIMM64_FULL_RANGE_OFF)
>     obj->arena_data_off =3D bpf_map_mmap_sz(map) -
> roundup(sysconf(_SC_PAGE_SIZE), sysconf(_SC_PAGE_SIZE));
>

(I assume roundup is roundup(arena->arena_data_sz,
sysconf(_SC_PAGE_SIZE))

I assume the trivial duplication of recomputing the rounded up value
here and in init_arena_map_data is fine - rounding up data_sz to the
nearest page is verbose but easy to understand imo.

> (note, we did all the correctness checks early in init_arena_map_data,
> we don't have to do any more here)
>
> and then the rest of the code stays exactly the same, down to the
> original memcpy(map->mmaped + obj->arena_data_off, ...), and no extra
> variables
>
>
>> +
>> +                                       memcpy(arena_globals, obj->arena=
_data,
>>                                                 obj->arena_data_sz);
>>                                         zfree(&obj->arena_data);
>>                                 }
>> @@ -6386,6 +6395,12 @@ bpf_object__relocate_data(struct bpf_object *obj,=
 struct bpf_program *prog)
>>                 case RELO_DATA:
>>                         map =3D &obj->maps[relo->map_idx];
>>                         insn[1].imm =3D insn[0].imm + relo->sym_off;
>> +
>> +                       if (relo->map_idx =3D=3D obj->arena_map_idx &&
>> +                           kernel_supports(obj, FEAT_LDIMM64_FULL_RANGE=
_OFF)) {
>> +                               insn[1].imm +=3D obj->arena_data_off;
>> +                       }
>> +
>
> here too we don't need feature checking, our obj->arena_data_off
> should have a valid value (might be zero, that's fine)
>
>>                         if (obj->gen_loader) {
>>                                 insn[0].src_reg =3D BPF_PSEUDO_MAP_IDX_V=
ALUE;
>>                                 insn[0].imm =3D relo->map_idx;
>> @@ -14456,7 +14471,7 @@ int bpf_object__load_skeleton(struct bpf_object_=
skeleton *s)
>>                 if (!map_skel->mmaped)
>>                         continue;
>>
>> -               if (map->def.type =3D=3D BPF_MAP_TYPE_ARENA)
>> +               if (map->def.type =3D=3D BPF_MAP_TYPE_ARENA && kernel_su=
pports(*s->obj, FEAT_LDIMM64_FULL_RANGE_OFF))
>>                         *map_skel->mmaped =3D map->mmaped + map->obj->ar=
ena_data_off;
>
> and here as well, no need to expose feature check here, we have
> map->obj->arena_data_off set correctly
>
>>                 else
>>                         *map_skel->mmaped =3D map->mmaped;
>> --
>> 2.49.0
>>

