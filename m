Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EEF4199D8
	for <bpf@vger.kernel.org>; Tue, 31 Mar 2026 23:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774999766; cv=pass; b=hfLbs9jCA3UjEIMsKPcADIy/CluwEjQXtcjyMcTQF4gwtz/+2OHktQLyW4zExf2JCP/VgixNBxPupZPEq2XAImAi4Lbx9P2ZasUWdRwwCrGtOIj/fZeBxQaoxj0d465MLdVUS3y8EtuENfkFK8h0RJ3SUiDT2J5s9jmCWJXSWV0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774999766; c=relaxed/simple;
	bh=DGtcnL1ZHkwcAqZL5SPxl5pFOsWzbDPKt2araBMqUi4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bmfei4BxDQkc9Yt6945Uo+ZQcrY2Lgv1k1uViarkymofHzWKEYocXGSLHKxhjSzcwno1qfrlmaICfOFgqRSytzEGg0aohySCRlVMvRpaBHf6cOQGn/n4h8sOfF9yoPI8CReBWXfrhVFJTnVa6yjssA6sLr5590krQ14jlOSVgYc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=roXEN2d9; arc=pass smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="roXEN2d9"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-43d01d6b50cso1969928f8f.1
        for <bpf@vger.kernel.org>; Tue, 31 Mar 2026 16:29:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774999763; cv=none;
        d=google.com; s=arc-20240605;
        b=I+PeamwioYnvd3TQrbTw4k6d5U7WfURkCF4JQNqqo4c7VbdCSbd5tObY3GxGgC9Onx
         d9cfX29ZdPfjlMl86fLze8XZ1xarcfovqyWmRIvrpleqMnXtIJqeixISTegXdYkQJ5K6
         jGfQ6utevMtuyHhMYWvemLu2Uq+FNZGaZrKIW6tacZcId6iSI3xPFjrzKDsk71/+cVE9
         Ye2NAPATgLOHSpgjk6E4ykFU4r39K8lncbVAbZmrTgPAZeoks94vc1tkAjn+n6ZWc4a8
         qRybJYbeMZpbxusfrdt1yvGuIcqsz+Moev/b9ri2gIOj5qf1IeS2IX2k+lqxe6KZz+7J
         MvBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DGtcnL1ZHkwcAqZL5SPxl5pFOsWzbDPKt2araBMqUi4=;
        fh=mfCH6ySoPI60ahOZm9SJKKpFB+lQgUzAD9SKmxYfC7k=;
        b=CCnfuCrfS+92CvObpOZFvktL3eY4l+sIA2hmORLzWp+2DBKZcYUT3VwWGvfUYPefhl
         dTkBtbMkWVb6ZeJTIBi06pzuid5qmnm3ZfHJn6yAYkJAOuIqdKdtI6iNGCATdpNry3AI
         +ioY6UNsqX6BdHiZZADjLpet2LAbNd3FZL5X5k2lFw3eo2+C0B6MAoIPzCTTVj61n/z4
         fELtIjLm7hyx34J/QVdIxEFe0cbDLVI+3ypu/1Gk6iEoSER8fXeTs696Z1lnRLYO2hFa
         qpvHN/S0WNcLrpYClBK1tCmbC4zT4nadYGwplKtBj7x+9bGKXNRt23dbKmcRnhAqw2EF
         FdlA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774999763; x=1775604563; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DGtcnL1ZHkwcAqZL5SPxl5pFOsWzbDPKt2araBMqUi4=;
        b=roXEN2d9FpjR7ot60qmEByNw+ElujLOO1/PIvLekMbguvmsYDCB7QjP4X/m/xMcBq8
         cvtO7b2Iti3PXgm29tT6x55QQXbwwxYLZTdt7HOuaVgS0BSCbNF8qGyGFJAU8Rl1gnGj
         zBLnJWvziX6kCzUOZ5pMTmvzdJ8Chkn1Xy3ZJAaIxwQ0FJuJ5TJwlXiHz6T+z4kAJaQE
         ItlwMh2Wc2tv/sbSuNwDKOi46V1udl9cts5RPQeW4DTFKK1omHzg+ZXmUVcPuc7mw5Ml
         8JQClgpfSSM69eIrd1McG6ugwdjrIr136ah8o4PYK1vhzlHzLc5dE5JhNxvEQPkn8sxz
         ViiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774999763; x=1775604563;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DGtcnL1ZHkwcAqZL5SPxl5pFOsWzbDPKt2araBMqUi4=;
        b=WNM8LbIoz+OmJ1rC0rJyKbN14s07HLTGJvWjU0mxJNZALMyOWLM0rapWkugN4m0O4k
         AtLI752X7d+OR3mn98Za70ywqjgoTHR/Yt3rFvMAgkZ6YpknfYi3Dj85dZ+RR4obosHe
         gssDAwUnUdeOg6s55ne1hvYIKZf8QSwxbKUbB4JScx2YHcn+E4k8nkJkNely++h/V2qm
         4zn/Vkavxisn3oa9Ume7F/17p9xcUgnIJpLfEg9Q2zHVnMvUHoBosCE9L5SDgu77aAr2
         rBCUwJoy0mdy7xNTHenHO5WPDyP2IABl1tRaFBbmkPgY7Bhh1bWXX4HpmMrT/RyptOJQ
         ddNw==
X-Forwarded-Encrypted: i=1; AJvYcCWRJElYq0DiiOUrBmzzVMvSO2C9crDMXohtuXsttIotNXFEFzYfsMKNJNJx0HW87zCn4Yg=@vger.kernel.org
X-Gm-Message-State: AOJu0YydC3vNZaW6I8U1SO7jxiP7HA8s3Ohi9Dc/WdL0cSBh13Zzwsdu
	V8xgJf749R3zw3DIKdeHVcjKwTVn6opjRJWbDSmDB8qqSf3A/v4tcEV/a2wJToAb1hVdXR++eu5
	Z18nVANcC9kKYXJlI0i8Esz6DnVaU22E=
X-Gm-Gg: ATEYQzzhGod0mzBdnXBhkxC/2h1o2T0fNG3bGpH1RJHKYPDPKUnXbwooJEPVgcFjA4i
	48q3cTJQx2LWkzt8KKPPF4r57OPFLSXsk+Wn4z2v7M9YlUtk5pCtUJiv24oRcv6KIPxr05MYXtP
	HH60+KK400WaVoDeoCqEDKljn42n81Wt7uaOd2l2s87Ra4b5DtqA1HGJsxW9MJa1QKcTuTrcRBv
	hPGuKPF4suvvc4ZvnLbWupn04ebp6TD3htkMQ1rVVxF9lTKGBfAaRAXKTc0weSaLFLTLkRwZgyx
	FAX0fXpQELUUanrUK4uxRSH89mmh8NbTVwi/pCtIaArFd0o2wwM2zZzA+7UdTTSKMsxgVjfqgeE
	0W3/PHuPlzcY+OdeVNHQh5Mxrdw==
X-Received: by 2002:a05:6000:1788:b0:43c:fb48:6851 with SMTP id
 ffacd0b85a97d-43d1506c682mr2912280f8f.21.1774999762634; Tue, 31 Mar 2026
 16:29:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260326090133.221957-1-tangyazhou@zju.edu.cn>
 <20260326090133.221957-2-tangyazhou@zju.edu.cn> <319906e9-3b47-472f-9a11-a0da60626144@huaweicloud.com>
 <9a61d64e-7943-4e39-8c82-c79bb9ac65b4@zju.edu.cn> <fa28e388-fbd4-43af-982a-828f5c0456eb@huaweicloud.com>
In-Reply-To: <fa28e388-fbd4-43af-982a-828f5c0456eb@huaweicloud.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 31 Mar 2026 16:29:11 -0700
X-Gm-Features: AQROBzA2OI9_9JHqL5hDKPR2m8IJkE61nj2uS5qNfM1_rulR904WCl0jBfEOqNg
Message-ID: <CAADnVQL5MKCqiEpa+vHA9TByBy0K-CPpSoJQ1_PF68kE6gxAwg@mail.gmail.com>
Subject: Re: [PATCH bpf v5 1/3] bpf: Reject bpf-to-bpf call with large offset
 in interpreter
To: Xu Kuohai <xukuohai@huaweicloud.com>
Cc: Yazhou Tang <tangyazhou@zju.edu.cn>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Yazhou Tang <tangyazhou518@outlook.com>, Shenghao Yuan <shenghaoyuan0928@163.com>, 
	Tianci Cao <ziye@zju.edu.cn>, Emil Tsalapatis <emil@etsalapatis.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 27, 2026 at 7:05=E2=80=AFPM Xu Kuohai <xukuohai@huaweicloud.com=
> wrote:
>
> On 3/27/2026 5:37 PM, Yazhou Tang wrote:
> > Hi Kuohai,
> >
> > On 3/26/26 21:45, Xu Kuohai wrote:
> >> Maybe I=E2=80=99m missing something, but since interpreters_args is a =
small array, why not
> >> just store the index (round_up(stack_depth, 32) / 32) - 1 in insn->off=
?
> >>
> >> That way, the interpreter could directly use this index to find the fu=
nction address,
> >> without needing insn->imm to record the address offset, thus avoiding =
the need to use
> >> another field like insn->off in the instruction to back up the origina=
l insn->imm.
> >
> > Thanks for the suggestion! Conceptually, storing the array index in ins=
n->off and keeping the 32-bits insn->imm unchanged is a very elegant way to=
 solve this problem.
> > But I think it will introduce a performance regression in the interpret=
er's hot path (___bpf_prog_run).
> >
> > Currently, the array lookup is done once during verification. The resul=
ting offset is stored in insn->imm, allowing the runtime to use a fast ALU =
addition: __bpf_call_base_args + insn->imm.
> >
> > However, If we store the index in insn->off instead, we force the runti=
me to perform a memory load (interpreters_args[insn->off]) on every single =
bpf-to-bpf call.
> >
> > Because of this overhead, rejecting out-of-bounds offsets at load time =
with -EINVAL (as done in v5) seems to be the safer and more performant trad=
e-off.
> >
> > What are your thoughts on this?
> >
>
> Do you have any performance data?
> TBH, I am curious if the overhead is even measurable.

I think it's a great idea. interpreter is a slow path.
The interpreters_args[insn->off] approach will let use remove
__bpf_call_base_args too.

Pls respin

pw-bot: cr
