Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5562D5937
	for <bpf@vger.kernel.org>; Sat, 21 Mar 2026 19:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774122596; cv=pass; b=MZeHTQhI0rfBC/AenxAKc7b//bsDYiCX7ijYIizlw6jqmbl0sSqNUh8SOlBLL2OvvrN8MdoT+z/oTSID0GhO5271UYDSfWu0TcRUqilDUaqenPX2xBS85MR7iRqvcpzC6WgGH1V5p4clzsmkPJagdGI96RTUNmNWHOJC6TbpxJo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774122596; c=relaxed/simple;
	bh=uMl+exZ3dp/41SG+vPFN+zEUkSBKBxqDQ5zP3dLg82w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nc6n4g3ZDnG+6j9sMcio8/5AorIvgiYKa/CDD0rvMIY2pafLg9/2Gatd489MJYRLoyj3i73PBnUh1n1c4AN68AKQ1Zyainlec5e5tWgRk3tJ7pB/UrwAn6lakE+FK4Eu9OSMBZUCnwRjD6IZvUIzzmfixlUj/iaLTTdN9J5kNyo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QRN9RjQe; arc=pass smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QRN9RjQe"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-43b527ac5d0so769977f8f.2
        for <bpf@vger.kernel.org>; Sat, 21 Mar 2026 12:49:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774122593; cv=none;
        d=google.com; s=arc-20240605;
        b=iL11EO6VFB1wTxyC0E0xJj0ICXaWKPpUk0gMQGA7/16rnY7osxjvlTYReLIkBAz8/1
         7CVE8yeroqk0nHyyxkvjHEvdll1sfhKE1r5XNz7AKeTaaN84NnsVVs/ooxWrrsE5XSne
         SKYJeualdMDZPmsbAOZU+y/CSlbGUFDCO/HbaOa+cPDR4mJqLhqV1TyYXi0cAt47xw1J
         JlMimZ8VuEWXSdx+6JkVVrZ4GuBKVPtqaCp5asqyiwDkHSvKfUb7lkr7CRdr3B3KCzlM
         bIbeO/nihd7R/AbfBiydWivLcrfz6y9sgTgb2HKzUPlyaap6WfmoTfkMox5of8Jfj3Jr
         U1Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DgQxcMvImid4gbeybu26AJE3Y3wBjv+/iITImgADi10=;
        fh=HMy25yxcoruThWnGRQeDVie2+bzAxy8q9V6ze63rows=;
        b=iKSXbtHRqYda6B6+VOwKzyQVLMCU7tE+Oc9UJMLZf1G2zkKyaZjcuXX2fBKL1Vg6mj
         IpEWpmgRkS8N/Ew0QjaFxgihA+svb1pP7wBLJqxngOt4T0vNRxnA8pEqz7+sgZH1S+/z
         lH91jXfMBPMKHxOJ9C5LE6ongMGCcTMgLRpO4WavVZtYHwE62ASf0jMOcePM4qu7O4Ld
         8MzghTfvuf7Vgw+my3gIjr0nKq6Aqfbpl34BkAO8zPvKSN71t8cfsU80Jgq0ugrb23JR
         PPF5QfqjjAY+s7bn5tMs1Iy/fwKyAK12YV3ZFjx36T6dFA/3FtUCcVafNaVNH5pr9Jkk
         j0fQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774122593; x=1774727393; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DgQxcMvImid4gbeybu26AJE3Y3wBjv+/iITImgADi10=;
        b=QRN9RjQeQo308gn/OdZJyYZwjgSjvmjGlQmTEdz5l6ht6GOFYr15WoedaKmr8TVQY9
         WryYIzUwZeMrA2doSKvrGvMI0MMi2/jWAsUTwAHHQ4mVVpkjrHtADlNluCSy5MVEIh1N
         Sn6lKOurLkFfV/L5e/Q0aVzpmEnTF/rdSNvrSRfE+bEHjgHEmHFqi6sDfAhkUwAt24By
         9e6YB3dme4mRWxNUB3YO8VHenEG43wsc8RlwhzpHDjUxQtq0359+PlUlzwSbZv4eLceu
         NZHElS0VIqj1yvBQhVTeiSHgoY9RfnmozTpA5/8qQWSCvIfIbOiGxAb/yNIOxdxvNs7V
         aWKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774122593; x=1774727393;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DgQxcMvImid4gbeybu26AJE3Y3wBjv+/iITImgADi10=;
        b=C7YSu0hY5sRrLxTUOcYoooM8ZxjHbZN1RgIQnwuUIhUGZ8noJmbo5aGvDTN2kqO7co
         0Fa70q2yOXm1/tksXUMebW51wzh2y9GbhZwaf7DBAN/CqBJeOKdLKxrHfYK4OtnVvnc0
         c+M/+vy1z4OkjM9xmAK5N5dNRzJ0r5tfNlsC506JmXC6xHGgaExSLJTo4sylpt9UnqrS
         ZJZNi2BYKC7HZxT4nXquS36p6zXevFcLHhLbjcJSpvKnr9/F0QQJ053A3Zh0TaxK9SGp
         6uoS9SM4BNEIKsTwavJ2DZOg8lCeq1YH/dg52uBU0tdM+CbgBrzI2r3gGzjNfo2AVy/r
         6xvg==
X-Forwarded-Encrypted: i=1; AJvYcCUnfIjFwqr/fTMdQN/cedl8VBGlYuRHsB28MSNaXDiavcN+cjKDMUw/SSDAiZFdt8uyM74=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFddkWoabPS9KLvpzOkPUxPm2+4c9epdIA3+2WPdOcHLEPfP5T
	pGF0k/3+6NJuhXg7vcqwN0dA14qnyRL6biAJ1F3nTl3wpDfrCdOGtc3icgOiIodakx2rWsdBG7u
	FrvCuw/59EKWVgLUQsY4Gre2+EFI8aQU=
X-Gm-Gg: ATEYQzzXedqPrbOUUSaNWtW1TDn3GmCaQB/hyialP2cL9XG3TFFS/xssQAx49kG6m3F
	EIC5IR0/E4090AkhHXVcqGOpdK+REOTwBHwPH0zysfznehcCS4g6xREBPUkUDxVl/k7KMYpIrkK
	v+YcXyzKHdixDiF0gyGlj8WuPO/AMA0th7sO1usFaeeaAGbpdQ1/8LVsnKQjTbsad9lpz3RO8m4
	7vWfgjt187yR9l70ZSKKtbQz3c9UeutFad/vwo+NIJg4LTOVpaPtH+ZaQNTKhdZ7cueZozKveMi
	1ZzgUTwgnKTTddskY7OyCdd466wLPluk7xt5D7gRXyVGbWgQxYwZ/D16MdL1FltfhB/JgXiGMfe
	bEOqt1gNh0pPbiStv1wPrlZGZtw==
X-Received: by 2002:a5d:5f55:0:b0:43b:45f5:eec with SMTP id
 ffacd0b85a97d-43b6423fc34mr11863264f8f.4.1774122593057; Sat, 21 Mar 2026
 12:49:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260321024446.692008-1-irogers@google.com> <20d77c80-6538-4dec-804c-156402c26534@linux.dev>
 <CAP01T76kB8BHSQXp_1+tScrHhQayVm+BhAiDqnq4NeNOS_cMQg@mail.gmail.com>
In-Reply-To: <CAP01T76kB8BHSQXp_1+tScrHhQayVm+BhAiDqnq4NeNOS_cMQg@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sat, 21 Mar 2026 12:49:42 -0700
X-Gm-Features: AaiRm527zj-86HKDU9TQg7EH9Yp0FEKxz_hD38hZCMjiPqjfidjcm-ljYcza0LM
Message-ID: <CAADnVQLKv6LOQw5=8_ZagRXdU7dRPYA+fxJsXiGncqJjZ2hK1w@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] libbpf: Fix strict aliasing violations in hashmap
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Yonghong Song <yonghong.song@linux.dev>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Ian Rogers <irogers@google.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	"linux-perf-use." <linux-perf-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 21, 2026 at 10:37=E2=80=AFAM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> On Sat, 21 Mar 2026 at 16:42, Yonghong Song <yonghong.song@linux.dev> wro=
te:
> >
> >
> >
> > On 3/20/26 7:44 PM, Ian Rogers wrote:
> > > The hashmap implementation contained strict aliasing violations.
> > > Specifically, the hashmap_cast_ptr(p) macro was casting pointers (suc=
h
> > > as void **) to long *, and these were subsequently dereferenced in
> > > functions like hashmap_insert(), hashmap_find(), and hashmap_delete()=
.
> > >
> > > C's strict aliasing rules (C11 6.5/7) prohibit accessing an object
> > > through an lvalue of an incompatible type. Dereferencing a long * to
> > > write to a void * object is a violation, even if they share the same
> > > size, as they are not compatible types. This can lead to undefined
> > > behavior, especially with aggressive compiler optimizations.
> >
> > Potentially this could be a concern. Did you actually find an issue
> > with it?
> >
> > The linux kernel build has
> >     KBUILD_CFLAGS +=3D -fno-strict-aliasing
> >
> > The libbpf does not have this flag. Maybe we should add '-fno-strict-al=
iasing'
> > for libbpf as well? This way, we can avoid any future potential
> > 'strict aliasing' issues.
> >
> > Note that bpf program (tools/testing/selftests/bpf/Makefile)
> > also has '-fno-strict-alaising' flag.
> >
>
> The change itself looks correct to me, fwiw, but as Yonghong said, we
> can add -fno-strict-aliasing to CFLAGS and move on. I also doubt the
> compiler can cause issues here, since the usage happens in hashmap.c
> which wouldn't be visible in other CUs where the call is made and
> pointers are passed in (unless compilers also do aliasing-based opts
> during LTO). I guess libbpf maintainers can decide what they prefer.

Agree. I don't think compilers can misoptimize things here.
It's safe to ignore this.

pw-bot: cr
