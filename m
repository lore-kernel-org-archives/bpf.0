Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 937C617993
	for <bpf@vger.kernel.org>; Tue, 17 Feb 2026 20:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771359962; cv=none; b=WS+KMXy25wDJcMVqK5X3V1znpcuZInzZdVh0B9nqcv5putNhaadgjLRiXy1TMhj1rJiGJvnF6wa+yfGTCpgbPaLSqi85eo8gAVKk2CP+6/bFclRa54vZ5RnigYK//kyDMF6p7RDY22cghLmZ1Th0z55xUyMH/yoitopdqSBHXjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771359962; c=relaxed/simple;
	bh=CPvfSpKqhmD/TROI6tkOWKlQBghQtSMeCquVA7tdBSM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=lXoOfnG5zcl1W+kJwd78jaCI/v+ixnqt4zK/d8bfiUTYoJdIdfI4dfoPDwmxxRQWHfyGJ0LBDvTtPtikT4rqDCwy3DENYaT0capFoV8gayqulBlIYTZcHex+hi1Boa/+Dn7agjKBBD5QR6NAEBDTz5o8prbR2uSMpARxzMsvo2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=pMWOmLH+; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="pMWOmLH+"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-8cb3e0093e3so435585685a.0
        for <bpf@vger.kernel.org>; Tue, 17 Feb 2026 12:26:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1771359959; x=1771964759; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LnwVuXCpRqj7z2V/DXGcBxKSzilbceTDvKeFA4ZATqs=;
        b=pMWOmLH+JgLnEctu2/9P6HpSeoksmlXwhqlZKV2xkcljefPA+zV2lzBH75IY4EpwnA
         KCA+xddTPVrN7bdIdedeHl2yljyQzb/npnfAKnUGwni7aQl/bAZs7smpvUAKHXyCXkVT
         XFmLK6pq8/Wp4lcNU+gXcW4S+67BP5Tz2ZTFEhdFeOH7fGMIEhmKWj96yigmCnL5/5Jx
         aKnWARaI8nBc1qVEXIyuRwV6BOAwExz6WZ6BbusadK9WWJXVDdQt/Xf81U9JMBcPSO/o
         T/3X1i+8I9Nk0uVwot6PfqTGgyDUJ26vn0wFBrYoALmdpIHEDGJuFaJMVsWSIlMnx1z4
         8kQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771359959; x=1771964759;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LnwVuXCpRqj7z2V/DXGcBxKSzilbceTDvKeFA4ZATqs=;
        b=J3zV9m6s5zq2JkgMqiz1yyS4ZBq+lZ1TZhcUhocPOiPJn7x/G/xuJDd9xr9Nc7MHd+
         YxaF0UQSPaRIQyCiLn0tOrEq9ppjBDFwwZv45SYRgeuGwYu+84k8dAt0IrUoHU41sV5s
         hknyue2zdSI7EDcRDrvPH8oS+5DdReOiQhuWkXRTBRPx8E+rxKRRGb8JLfFurBdAz89H
         9i7O2bubZto/5gf6SAYvxQt8Xiyqp1xb2sG3dXMJ6q3TrkrxR1PY2eBvKVdzeGmAk4ma
         URWh+7tKPYPjdkn9u/zKIZBTmwJH9DBUjyAsUeYSQ+Y0qWQi7a/rL/Z9R6pwVBxCp15R
         V8lw==
X-Gm-Message-State: AOJu0YyetG4h/IkPgBZrW+kpoHONz0Y7UrPbNhT3WPSMrFJ+LwkPvFT0
	sAxhvdtV9M9RTETybdxNFw3h8cPtbe8cwUhKUOKM+Gnwv0f9nGlN3MxJvCP4vBRdtar8pk//puz
	tydClk0g=
X-Gm-Gg: AZuq6aJfZMvEPCbvy/mL4c2/dLgcNc/q0a2+Mr4Ec4njL6ZXv7D7vUSAaUH852WxiTO
	ltbNC50IyuJ7WeNytSJl/KKDNGTpk9pgGrC6YAsrmLSVfLMrTfCB90CcViMoEYnaUVFwfJqivWi
	6Ca2rkYX9/pDhuWn7CvqA2AaK01AVqmAe7vftLkghExCqWFWIZ59mzSDcub+i7Y7bDBZUijRKS6
	GBrwE9YQQGdvNhcmjho2pFWCtqPogMjEV+F/B34cvvovF6zaNod+uhUzvdiOHahrbhXawX7YYE2
	1FN6palw/kSkr9qAqD/FXzvvPk8kbTsZ2r53bHkc1xwAP4dn7PJT1mXYpDk0J/eKehw4uoRPLwJ
	qwiAJvv8wCdsjxqBPZGbMeQWjAk4HWvOkXQrYxJUCo9drrohCQyrIMXSrJpAaQQkcxH/3Ufb8sl
	pMpNQuiXNg5MPsidltPK/UsFG3QTvHn64pVg==
X-Received: by 2002:a05:620a:7087:b0:8ca:4288:b16c with SMTP id af79cd13be357-8cb4242a572mr1710997485a.54.1771359959361;
        Tue, 17 Feb 2026 12:25:59 -0800 (PST)
Received: from localhost ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8971cc91eccsm167270016d6.13.2026.02.17.12.25.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Feb 2026 12:25:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 17 Feb 2026 15:25:58 -0500
Message-Id: <DGHIP6RRT8PO.1K1KDOR36O39@etsalapatis.com>
Cc: <bpf@vger.kernel.org>, <ast@kernel.org>, <andrii@kernel.org>,
 <daniel@iogearbox.net>, <john.fastabend@gmail.com>, <memxor@gmail.com>
Subject: Re: [PATCH bpf v2 2/2] libbpf: Delay feature gate check until
 object prepare time
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Emil Tsalapatis" <emil@etsalapatis.com>, "Andrii Nakryiko"
 <andrii.nakryiko@gmail.com>
X-Mailer: aerc 0.20.1
References: <20260214021014.15670-1-emil@etsalapatis.com>
 <20260214021014.15670-3-emil@etsalapatis.com>
 <CAEf4BzYVWzQJ5p2ryGZGj-s6BfxS+qrKyKCS6JrMbVJZGd5KTQ@mail.gmail.com>
 <DGHHUROFGUVL.1ADAK5BHSHCLP@etsalapatis.com>
In-Reply-To: <DGHHUROFGUVL.1ADAK5BHSHCLP@etsalapatis.com>

On Tue Feb 17, 2026 at 2:46 PM EST, Emil Tsalapatis wrote:
> On Tue Feb 17, 2026 at 2:03 PM EST, Andrii Nakryiko wrote:
>> On Fri, Feb 13, 2026 at 6:11=E2=80=AFPM Emil Tsalapatis <emil@etsalapati=
s.com> wrote:
>>>
>>> Commit 728ff167910e ("libbpf: Add gating for arena globals relocation f=
eature")
>>> adds a feature gate check that loads a map and BPF program to
>>> test the running kernel supports large direct offsets for LDIMM64
>>> instructions. This check is currently used to calculate arena symbol
>>> offsets during bpf_object__collect_relos, itself called by
>>> bpf_object_open.
>>>
>>> However, the program calling bpf_object_open may not have the permissio=
ns to
>>> load maps and programs. This is the case with the BPF selftests, where
>>> bpftool is invoked at compilation time during skeleton generation. This
>>> causes errors as the feature gate unexpectedly fails with -EPERM.
>>>
>>> Avoid this by moving all uses of the FEAT_LDIMM64_FULL_RANGE_OFF featur=
e gate
>>> to BPF object preparation time instead.
>>>
>>> Fixes: 728ff167910e ("libbpf: Add gating for arena globals relocation f=
eature")
>>> Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
>>> ---
>>>  tools/lib/bpf/libbpf.c | 31 +++++++++++++++++++++++--------
>>>  1 file changed, 23 insertions(+), 8 deletions(-)
>>>
>
> Hi Andrii,
>
> ack to this and the point for the first patch, two minor followups below.
>
>>
>> This works, but see some suggestions for a follow up to contain
>> feature-checking a bit better
>>
>>> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
>>> index 93e59ed8d9a1..ff38a9db1b13 100644
>>> --- a/tools/lib/bpf/libbpf.c
>>> +++ b/tools/lib/bpf/libbpf.c
>>> @@ -3009,11 +3009,11 @@ static int init_arena_map_data(struct bpf_objec=
t *obj, struct bpf_map *map,
>>>         memcpy(obj->arena_data, data, data_sz);
>>>         obj->arena_data_sz =3D data_sz;
>>>
>>> -       /* place globals at the end of the arena (if supported) */
>>> -       if (kernel_supports(obj, FEAT_LDIMM64_FULL_RANGE_OFF))
>>> -               obj->arena_data_off =3D mmap_sz - data_alloc_sz;
>>> -       else
>>> -               obj->arena_data_off =3D 0;
>>> +       /*
>>> +        * possible offset for arena globals into the arena,
>>> +        * if supported at load time
>>> +        */
>>> +       obj->arena_data_off =3D mmap_sz - data_alloc_sz;
>>
>> I'd keep this obj->arena_data_off at zero at this point (we don't use
>> it until prepare step, skeleton also just uses obj->arena_data
>> directly without offset during open phase)...
>>
>
> Do we even want to keep the assignment? The field should be 0 by default =
since=20
> we're calloc()'ing the object.
>
>>>
>>>         /* make bpf_map__init_value() work for ARENA maps */
>>>         map->mmaped =3D obj->arena_data;
>>> @@ -4672,7 +4672,7 @@ static int bpf_program__record_reloc(struct bpf_p=
rogram *prog,
>>>                 reloc_desc->type =3D RELO_DATA;
>>>                 reloc_desc->insn_idx =3D insn_idx;
>>>                 reloc_desc->map_idx =3D obj->arena_map_idx;
>>> -               reloc_desc->sym_off =3D sym->st_value + obj->arena_data=
_off;
>>> +               reloc_desc->sym_off =3D sym->st_value;
>>
>> this is good, relos don't need to record this offset...
>>
>>>
>>>                 map =3D &obj->maps[obj->arena_map_idx];
>>>                 pr_debug("prog '%s': found arena map %d (%s, sec %d, of=
f %zu) for insn %u\n",
>>> @@ -5556,6 +5556,7 @@ bpf_object__create_maps(struct bpf_object *obj)
>>>  {
>>>         struct bpf_map *map;
>>>         unsigned int i, j;
>>> +       char *arena_globals;
>>>         int err;
>>>         bool retried;
>>>
>>> @@ -5633,7 +5634,15 @@ bpf_object__create_maps(struct bpf_object *obj)
>>>                                         return err;
>>>                                 }
>>>                                 if (obj->arena_data) {
>>> -                                       memcpy(map->mmaped + obj->arena=
_data_off, obj->arena_data,
>>> +                                       /*
>>> +                                        * Only relocate the globals to=
 the end of the arena
>>> +                                        * if the kernel supports it.
>>> +                                        */
>>> +                                       arena_globals =3D map->mmaped;
>>> +                                       if (kernel_supports(obj, FEAT_L=
DIMM64_FULL_RANGE_OFF))
>>> +                                               arena_globals +=3D obj-=
>arena_data_off;
>>
>> and here I'd instead set arena_data_off to its final value (zero or
>> proper offset), something like
>>
>> if (kernel_supports(obj, FEAT_LDIMM64_FULL_RANGE_OFF)
>>     obj->arena_data_off =3D bpf_map_mmap_sz(map) -
>> roundup(sysconf(_SC_PAGE_SIZE), sysconf(_SC_PAGE_SIZE));
>>
>
> (I assume roundup is roundup(arena->arena_data_sz,
> sysconf(_SC_PAGE_SIZE))
>
> I assume the trivial duplication of recomputing the rounded up value
> here and in init_arena_map_data is fine - rounding up data_sz to the
> nearest page is verbose but easy to understand imo.
>

Actually there is an issue: If we move the flag check here, then we
haven't properly calculated arena_data_off by the time we do the
relocations in bpf_object__relocate_data(). I'll just put the single=20
feature in bpf_object__realocate instead.

>> (note, we did all the correctness checks early in init_arena_map_data,
>> we don't have to do any more here)
>>
>> and then the rest of the code stays exactly the same, down to the
>> original memcpy(map->mmaped + obj->arena_data_off, ...), and no extra
>> variables
>>
>>
>>> +
>>> +                                       memcpy(arena_globals, obj->aren=
a_data,
>>>                                                 obj->arena_data_sz);
>>>                                         zfree(&obj->arena_data);
>>>                                 }
>>> @@ -6386,6 +6395,12 @@ bpf_object__relocate_data(struct bpf_object *obj=
, struct bpf_program *prog)
>>>                 case RELO_DATA:
>>>                         map =3D &obj->maps[relo->map_idx];
>>>                         insn[1].imm =3D insn[0].imm + relo->sym_off;
>>> +
>>> +                       if (relo->map_idx =3D=3D obj->arena_map_idx &&
>>> +                           kernel_supports(obj, FEAT_LDIMM64_FULL_RANG=
E_OFF)) {
>>> +                               insn[1].imm +=3D obj->arena_data_off;
>>> +                       }
>>> +
>>
>> here too we don't need feature checking, our obj->arena_data_off
>> should have a valid value (might be zero, that's fine)
>>
>>>                         if (obj->gen_loader) {
>>>                                 insn[0].src_reg =3D BPF_PSEUDO_MAP_IDX_=
VALUE;
>>>                                 insn[0].imm =3D relo->map_idx;
>>> @@ -14456,7 +14471,7 @@ int bpf_object__load_skeleton(struct bpf_object=
_skeleton *s)
>>>                 if (!map_skel->mmaped)
>>>                         continue;
>>>
>>> -               if (map->def.type =3D=3D BPF_MAP_TYPE_ARENA)
>>> +               if (map->def.type =3D=3D BPF_MAP_TYPE_ARENA && kernel_s=
upports(*s->obj, FEAT_LDIMM64_FULL_RANGE_OFF))
>>>                         *map_skel->mmaped =3D map->mmaped + map->obj->a=
rena_data_off;
>>
>> and here as well, no need to expose feature check here, we have
>> map->obj->arena_data_off set correctly
>>
>>>                 else
>>>                         *map_skel->mmaped =3D map->mmaped;
>>> --
>>> 2.49.0
>>>

