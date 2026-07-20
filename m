Received: from mail-wm2-f10.google.com (mail-wm2-f10.google.com [74.125.225.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B896B429006
	for <bpf@vger.kernel.org>; Mon, 20 Jul 2026 14:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784557489; cv=none; b=JlCZbOl4RPZOvd7lKTejnjktV2q/tkbXOerMlI+HpK6t2Zz/GHwim9ts2Qy7RHbtz2AZvxc+Njd5fizlD/TpgTulpNKsSQ5pELi1olhoYiwmWxrvlLHJdg9PTzInG+USrgM028Bj8j+iJiAHWiK9jc7DLCJ9Z1aY+jkiBxw6I24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784557489; c=relaxed/simple;
	bh=WY4da/eZLxxQmiBbPjg8+Of4x2fEz1afwkY5i+KDZGo=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=aUQem5W7g/lR2zdlyUTmY01rqze3sevvBxSen//HWU6hyY67DTy5XwzlE9cErvDpGq7FAyDXJL1x9U2v2UT+FPQiq3hbVfOeqxaOI7QFrfFxpWlyABfkdsrg7urz11ALutUOx2kBWu6APCclvBXluy03e6xmcnbndPrMbCj+Jww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BPThb9AI; arc=none smtp.client-ip=74.125.225.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BPThb9AI"
Received: by mail-wm2-f10.google.com with SMTP id 5b1f17b1804b1-495501e57beso6703175e9.1
        for <bpf@vger.kernel.org>; Mon, 20 Jul 2026 07:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784557486; x=1785162286; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=WY4da/eZLxxQmiBbPjg8+Of4x2fEz1afwkY5i+KDZGo=;
        b=BPThb9AIb0DY1uqtP98pAceUa726XNT6s7fy0bOABefqTOrhBj+YsSJCbFMxnK0Ra0
         dQ0tYrrpQWjADBL2IJki1Fbv53823/lOAl2xJu0l1WSdGW1fJQ2f3Nht7OciivXF1pIE
         nQxSyFyQcwm6MoGXCNff2X/x7iGZUzQCOBI1w0GR81ViTKKMc38XVnTm52HnGptiFZuZ
         FAmYf8xcQhsFgpxXF+laX1stcPYLT2syKUTEbnV3OXITxdJpakYsC/0d+7XsOklBsIME
         ys9Y9QHGicu6ZEhneBwJKrMY+VUVkGjQohOF10y2hvHMP+Glnjo349Cf2c5LOjEMqTQp
         uzzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784557486; x=1785162286;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WY4da/eZLxxQmiBbPjg8+Of4x2fEz1afwkY5i+KDZGo=;
        b=QNk8IIctNv8VyWbASrKWwBCPWvr9tb0OlNBOKpghATmqUcSn9Xnibrr+ENc/lKz5V3
         VhEZM7O5/q06ZvqiAocR50d+iLf5KzgAtpFpI+8AYmlfm1/+m3+1sLObqZjp0STTDcHR
         tyDgY5qfEM1l0P3DaPtZkGWXiODhC8GDuvg5zMcjNmPoyiMvaSd447DVlsn7JjIzftxJ
         BZpdyaVLysnW2/vjUnNtRvxs0IqPh1qZm4yyDzAq11W+EqHkCyJs/yu+mRd/Ll1fEngt
         DOMpZeBSeHf9kM4Xk4Psk8P3HwET0COcBiQlOW8Nk/itLiL8FpZzhEhgkNbTcuiophT2
         VGgw==
X-Forwarded-Encrypted: i=1; AHgh+RqXOODhoQTR/Y/tXX3dfTdlFDsN3K9UrsBmEq0xTE6zidAWy7lW8TUDbXiApg5DMAc+OZ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCki5nSJemQiTNEEpFqN3jjveKytqqeqghYeYbNTrNDemZ1Ji7
	v1dqsmuoHWS8KVHO3y15gtSiYwt4bOIaz+cUK6POlps6etsBkbSljZ0t
X-Gm-Gg: AfdE7cmXOfx7wOZlnsO5TUpIg7zXSPiQBMbFPzAzieXcK2pMwNEOkrBJ7tbL653/V2K
	1ct/mk/yLHMLvYtjvk9USq6tavubp3QqadopIKVAZ8fNNwsxiS6AvTyuh8gnRZzaeGUlCTFLCL1
	5EQKbaKgt22hGlof/SD2eQ0hF0LI6A+Ci2+eF8Yiq7dMXAH4jjmma/S67Pqs2j+/xkpNKyXLmV2
	BAYmKVoX0c4KZIDJv9R/3qQYuKpd3owI71Fg4uGyXsIUzwvsVxBaZDq3eN7ehDsTvFMdSXPC04M
	IWZoWWvKOGDk0AMTYszvioKN627LgsWifMaFwLV+p6K5KUz9icBb6x9wPy9clG5b3gUUyE5y8mO
	7m1gmVle6RkFrYHtUoqkOjfTDaokmYLF+4zrfgQVKkVIIl1cttQ5k8IW5S+fE/YOXrchTtSv1zX
	2eYDNC98IYfdxlwxA3i+KyJNbRNdWuuATaGJAde7I+ggGtuS1WGediobcfnLU0BFPW7IXI3g3d/
	uRWWz+ahWeebuEeh5pdCz6YslTZBXtrxzLTFAryZGF3nbTMJfWOrsc=
X-Received: by 2002:a05:600c:ad7:b0:495:3c6d:f294 with SMTP id 5b1f17b1804b1-4954a402da3mr118155185e9.23.1784557485673;
        Mon, 20 Jul 2026 07:24:45 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f67466e09sm32026063f8f.21.2026.07.20.07.24.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 07:24:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 20 Jul 2026 16:24:44 +0200
Message-Id: <DK3GTYQ5UOMO.CVL471XPD0AT@gmail.com>
Cc: "Daniel Borkmann" <daniel@iogearbox.net>, <bot+bpf-ci@kernel.org>,
 <bpf@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>, <ast@kernel.org>, <andrii@kernel.org>,
 <eddyz87@gmail.com>, <martin.lau@linux.dev>, <song@kernel.org>,
 <yonghong.song@linux.dev>, <john.fastabend@gmail.com>,
 <kpsingh@kernel.org>, <sdf@fomichev.me>, <haoluo@google.com>,
 <jolsa@kernel.org>, <puranjay@kernel.org>, <pjw@kernel.org>,
 <palmer@dabbelt.com>, <alex@ghiti.fr>, <pulehui@huawei.com>,
 <martin.lau@kernel.org>, <clm@meta.com>, <ihor.solodrai@linux.dev>
Subject: Re: [PATCH bpf-next v6 6/7] riscv, bpf: Mixing bpf2bpf and
 tailcalls
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "Pu Lehui" <pulehui@huaweicloud.com>, =?utf-8?q?Bj=C3=B6rn_T=C3=B6pel?=
 <bjorn@kernel.org>
X-Mailer: aerc 0.21.0
References: <20260708064436.2971933-7-pulehui@huaweicloud.com>
 <a721df30ec2f824295000183c8e91f2c19d0bd56ae115b835b402be9eacc1c71@mail.kernel.org> <b4aadfde-9745-4c71-8dd4-ce433331f91b@huaweicloud.com> <CAJ+HfNi_icVbeB=jw-xnXrwzigZwP2OVRbzaF3VC87i6fDpdDw@mail.gmail.com> <fc972c33-1b66-4979-97e9-71627fb6179f@huaweicloud.com> <CAJ+HfNgPWwX3dfu=62TSMKeLD8m9S0rc2k9G8rVN7r2SuzQ6MQ@mail.gmail.com> <23cb9eac-1775-44b8-a9ec-10edde808a30@huaweicloud.com> <326eda4a-39e6-4f1e-8fe5-dc1cc9ae6739@iogearbox.net> <dd20e3ea-4b3a-45d1-99f4-79e99e51e7fb@huaweicloud.com>
In-Reply-To: <dd20e3ea-4b3a-45d1-99f4-79e99e51e7fb@huaweicloud.com>

On Fri Jul 17, 2026 at 9:37 AM CEST, Pu Lehui wrote:
>
>
> On 2026/7/10 17:43, Daniel Borkmann wrote:
>> On 7/10/26 2:53 AM, Pu Lehui wrote:
>>> On 2026/7/10 3:51, Bj=C3=B6rn T=C3=B6pel wrote:
>>>> On Thu, 9 Jul 2026 at 17:09, Pu Lehui <pulehui@huaweicloud.com> wrote:
>>>>> On 2026/7/9 19:37, Bj=C3=B6rn T=C3=B6pel wrote:
>>>>>> Sorry for the delay here -- the bot had me thinking a bit.
>>>>>>
>>>>>> On Wed, 8 Jul 2026 at 10:54, Pu Lehui <pulehui@huaweicloud.com> wrot=
e:
>>>>>> ...
>>>>>>
>>>>>>>> This assumes a fixed number of instructions before the tailcall
>>>>>>>> entry
>>>>>>>> point. When is_subprog is true, the rv_addi() instruction is not
>>>>>>>> emitted,
>>>>>>>> which means the tailcall entry point moves forward by 4 bytes
>>>>>>>> relative to
>>>>>>>> where RV_TAILCALL_OFFSET expects it to be.
>>>>>>>>
>>>>>>>> The tailcall entry is used in emit_bpf_tail_call() when
>>>>>>>> calculating the
>>>>>>>> jump target for the tail call. If RV_TAILCALL_OFFSET doesn't
>>>>>>>> account for
>>>>>>>> the conditional emission, could this cause the wrong entry point
>>>>>>>> to be
>>>>>>>> used when tail calling into subprograms?
>>>>>>>
>>>>>>> This is not an issue, subprog can not be the tailcall callee.
>>>>>>
>>>>>> Say, that we have an entry function that does bpf_for_each_map_array=
()
>>>>>> into a callback cb(). cb() is a subprogram, so no init of TCC. Now,
>>>>>> cb() calls another subprogram that does a tailcall.
>>>>>>
>>>>>> The callback to cb() is coming from the kernel, so a6 could have bee=
n
>>>>>> clobbered, no? We're entering a subprogram coming from the C ABI. No=
w,
>>>>>> if the callback calls a subprog that's tail-call reachable, the TCC
>>>>>> can be garbage?
>>>>>
>>>>> Sashiko reported the same issue yesterday. I verified that the verifi=
er
>>>>> rejects cases where a tail call is invoked within a callback;
>>>>> specifically, while the callback's return value range is [0, 1], the
>>>>> simulation of the exit path in `check_helper_call` (handling the tail
>>>>> call helper) marks R0 as UNKNOWN, causing the verifier to reject
>>>>> it=E2=80=94so I
>>>>> didn't investigate further. However, I just verified that the verifie=
r
>>>>> *does* accept the scenario where a callback calls a subprogram, and
>>>>> that
>>>>> subprogram subsequently calls a tail call. I believe this scenario
>>>>> ought
>>>>> to be rejected; perhaps some changes are needed in the verifier,
>>>>> otherwise tail calls on other architectures (like x86) would also be
>>>>> susceptible to infinite loop issues.
>>>>
>>>> Thanks for trying it out!
>>>>
>>>> Ok, so seems like we need a verifier fix pre-landing?
>
> Hi Bj=C3=B6rn,
>
> Just a quick note that the verifier fix we discussed has now landed in
> bpf-next [0]. Looking forward to your feedback on v6 whenever you get a
> chance. :)

Yep, if there are no more concerns, it would make sense to pull this in.

Bj=C3=B6rn, what do you think?

> [...]
