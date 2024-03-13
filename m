Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37C512E6C
	for <bpf@vger.kernel.org>; Wed, 13 Mar 2024 21:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710363728; cv=none; b=dosaooa2wPLI3GdVjmRbC1uN+jbyNPyCTJGUJ7YNGJSjrfFZt7leMpSZ/Z2RE4fmJevtjkl8NxoDG5a8Zauujb5E2kv2FkYukX/3tHTq/HwSifSboRKFPtdWnCvm9Gu1/z7OC+3NgospxNjohJ4vQ4ww3Rgy2ob/MojJ96Dwjf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710363728; c=relaxed/simple;
	bh=yqD0xySjwcxJYaNSfEggYXwyl+UN4Yk6HdWAV4mFeRA=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=lE/543TafREn2+Srch2A48jI7D5PVJ2gRNGaXt6ZpBphIQX0lJ4lNHxxMVJNu2TQeTorVjdOXvN3F5pupM6onpDDCPP0nJi2R+S6TCtg9/cWVLHrT4/rOB4GRnrxvuPRq0tGcJUXBi4HI1GWUw6uMvU8rPH1fs9D1XCNzQFe7X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=L4xo+53Q; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="L4xo+53Q"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-413f0ce50b6so713515e9.3
        for <bpf@vger.kernel.org>; Wed, 13 Mar 2024 14:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1710363725; x=1710968525; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MxXXNEXYedOe949/5ExPM39bkL7aMtWRMXTPf6N1ikc=;
        b=L4xo+53QNqsFdxnwv+A66UTjOwmqNNN8jjKP/lTSALP3H3B53/zKtv0IqBLamfS2hn
         uFuacx282tchaazfj5yfpsF/+SFuyjoK+H1BN4nfh8nK+yr4y1Tgm8SRsUM3C+vsXaeD
         tE2dkL0V9DTQCE3ejOdQATKDlGEMksNviCg01U8STrbGhnUWaVSiBZ6+fVlwU6C3xDaI
         5g2pmBUroDjCiPL6kMtKJFJOVJkpxRqKX8xIAvGHVl+EP5lwtBVhkF2wZfU4awiwmm/9
         dIXUTX9P90xoky7GNipJM+olu+MIrMU0Wt+bmS0CSlKQepE6TwImtXvooIAEkb6MZ2tS
         dWdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710363725; x=1710968525;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MxXXNEXYedOe949/5ExPM39bkL7aMtWRMXTPf6N1ikc=;
        b=T51cOhvQY+jJnO92yOHkvMjlW+JSO61Vvi58Jxu25RO5FnrmscUO4FqlkZajrpL6fI
         iMsHhpMsfHkHD7EwvphS4tT7j0cMSiCQt2LEkd0+H6+id8SAaFv5Tcx1HNZCmr+xRHjv
         5vvNm2IQwebzXvWjI+V6F5w82mHakrTXgE7WlGY1zmWh9IFhfJ0nFi1ZvWOD1dOx4Oui
         r7lcHbYnQSOU6fCaUPRj2XY6kvb0ucXP3uYwUzNErfWATBOfCwcYFMtp9PxGq3LvTlaj
         Asv0niuMS8iJmAKcSck3jRoSiBDC0Zr+NEpnpPDz0oO9Ai/5HC4KOL9VRqfwj5kLigEY
         nYvg==
X-Forwarded-Encrypted: i=1; AJvYcCUfzyzlZcBOSBfpRCUMUC+zCBn5N8co5juuJmtSLDJ7VgwvoMQK7CFdJOWfdVl9PtKsY/fkIJmF45dwR2sZ+vzh8z2s
X-Gm-Message-State: AOJu0YxUt4GqNNbfe2dPGL8nIxoXHQRRG+spxglf0/w9ybEatmm+H+v7
	ri//Bsg0Fcx4UoFLSDwKULoCnOav7nRD5N6oUULFInYRB6oWbXZzXStMnz0ARiw=
X-Google-Smtp-Source: AGHT+IFkWoS25Iojqboki9WfDQuQu+oKN8VsOYyK+ua+T+XPO5TedBimaND3DmoMaonM84pezQ1oeA==
X-Received: by 2002:a05:600c:1c09:b0:413:ef04:d347 with SMTP id j9-20020a05600c1c0900b00413ef04d347mr628060wms.10.1710363725084;
        Wed, 13 Mar 2024 14:02:05 -0700 (PDT)
Received: from ?IPv6:::1? ([2a02:8011:e80c:0:54f5:a101:e96b:a659])
        by smtp.gmail.com with ESMTPSA id bi18-20020a05600c3d9200b004133825e649sm208061wmb.33.2024.03.13.14.02.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Mar 2024 14:02:04 -0700 (PDT)
Date: Wed, 13 Mar 2024 21:02:03 +0000
From: Quentin Monnet <quentin@isovalent.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
CC: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_bpf-next=5D_Revert_=22libbpf=3A_make_uni?= =?US-ASCII?Q?form_use_of_btf=5F=5Ffd=28=29_accessor_inside_libbpf=22?=
User-Agent: K-9 Mail for Android
In-Reply-To: <CAEf4BzbC4_x6qNT-9Tzq0D85NrxU5vDz_rpT83mg0PHypDRnQA@mail.gmail.com>
References: <20240313172345.75270-1-quentin@isovalent.com> <CAEf4BzbC4_x6qNT-9Tzq0D85NrxU5vDz_rpT83mg0PHypDRnQA@mail.gmail.com>
Message-ID: <F6FC7374-3431-4BC8-9CDC-21C0A1F79246@isovalent.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 13 March 2024 17:39:14 GMT, Andrii Nakryiko <andrii=2Enakryiko@gmail=2E=
com> wrote:
>On Wed, Mar 13, 2024 at 10:24=E2=80=AFAM Quentin Monnet <quentin@isovalen=
t=2Ecom> wrote:
>>
>> This reverts commit df7c3f7d3a3ddab31ca8cfa9b86a8729ec43fd2e=2E
>>
>> There's no guarantee that obj->btf is non-NULL when passing it to
>> btf__fd(), and this function doesn't perform any check before
>> dereferencing its argument=2E As a consequence, this commit caused
>> segmentation faults in bpftool (for example) when trying to load
>> programs that come without BTF info=2E
>>
>> Signed-off-by: Quentin Monnet <quentin@isovalent=2Ecom>
>> ---
>>  tools/lib/bpf/libbpf=2Ec | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tools/lib/bpf/libbpf=2Ec b/tools/lib/bpf/libbpf=2Ec
>> index efab29b8935b=2E=2E0f9a4d232468 100644
>> --- a/tools/lib/bpf/libbpf=2Ec
>> +++ b/tools/lib/bpf/libbpf=2Ec
>> @@ -7343,7 +7343,7 @@ static int bpf_object_load_prog(struct bpf_object=
 *obj, struct bpf_program *prog
>>         load_attr=2Eprog_ifindex =3D prog->prog_ifindex;
>>
>>         /* specify func_info/line_info only if kernel supports them */
>> -       btf_fd =3D btf__fd(obj->btf);
>> +       btf_fd =3D bpf_object__btf_fd(obj);
>
>oh, my bad, sorry about that=2E But I'd still like to stick to using
>btf__fd(), so maybe let's fix forward by dropping btf_fd variable here
>and doing what bpf_object__create_map() does:
>
>if (obj->btf && btf__fd(obj->btf) >=3D 0 && kernel_supports(=2E=2E=2E)) {
>    load_attr=2Eprog_btf_fd =3D btf__fd(obj->btf);
>    =2E=2E=2E
>}
>
>?

I half-expected that :)=2E I don't mind at all, I'll send an updated versi=
on tomorrow=2E Thanks!
