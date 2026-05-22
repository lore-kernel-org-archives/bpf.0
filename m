Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D6393C2BB9
	for <bpf@vger.kernel.org>; Fri, 22 May 2026 17:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779470022; cv=none; b=ZCHkVNVQhel6C5CXCDmkn0BLcjGIg+XSavId5CbwS+BXg/P5izNxSnvRGvlvE43i047wATDYjHx45Eb2YXpfh0G3tBwwaRzaNqMnEA3CEqRShzSFSSIIr8DuVCzWWZ+9JqhavpJaxcRHzuSwRUZmZ7w5sGjoqYY0/rzP+kkuAjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779470022; c=relaxed/simple;
	bh=a+CInxeSB1Zqe7+X7tbNilMFXAdB47JkuFSLHzgtQp0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=Kd7YUuAdSc3qgRtOFrsg+RFI2LBpkPXaAK2Q5Y20FkGL3eVufk3NjX3Gt61/ztrpfcZXXjw0FL7Z6dNSttSVnynw10f29mf+v+EwUjhhYioS8CejtUWFQj6Olj7AkXSTP3Jaq3EE0NFE46yAiKd9m7CRbSu+/Z7q2AI55phus64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=mb5avOus; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="mb5avOus"
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-3042dffd80bso3546655eec.0
        for <bpf@vger.kernel.org>; Fri, 22 May 2026 10:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1779470020; x=1780074820; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wY4I8lMoFI92sp/KvSm+KBFNyjnf2+5FqBSVyBYIdTY=;
        b=mb5avOusvH++FgQcBBfSDMOsB1NyLQKilnVtcHQxyJBsnXRzm8q4NnE7ilDv/f/pnL
         h7SgTyEQyWIQknSdq+vG2gLE0yQyhn5Hdk4du3LBRrVNfY5p4c095DyH2/28wqcdxVgj
         KABArBH7YfUiM7LF7AAroA/UIdMn5oSDk4+13FWGXmk0UdrpNQzkB6l4idqTrTh8YCIN
         2i592+RByhRugCuxZ2YQuWOjRnKhZMPwKQwZFZm2mhXu2/4XITbQS7bEl9bi5oaNd+HL
         XOIKThbxeedA0VS0iGfhfz80NsrYsQ9xnAvCi0uBKHRCGPvAnsbXzZflULPXAKGgYrGM
         jb9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779470020; x=1780074820;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wY4I8lMoFI92sp/KvSm+KBFNyjnf2+5FqBSVyBYIdTY=;
        b=prqDFRMQtjAPB+6c672Il5VK22fZ20E1dGGVlBPS111IYC80aHlCkt1nzaYtv8F7iC
         1AfdryXdBX25G4dKE0VkkbfeZE10B7dhcRLSQsBQQaHxcD9GRg7eKb/6R5lnNHycNQfk
         OcCQMK+wv+LVm+aYlMZhzpK8G+tNompSlzCxcI2alHpJOh1rrHgLR/raGdOLmPaaLr9S
         2myLdBD+Nbv01vHZxQoQ024uBNPEFj3i6jcCsJuYLXVkyv2GyWMSeiH3+urUz0DRk+GN
         w2kgAAhrvZLvxhEbCKpwVdRXKtU6pt0+rynVwv0W5aT8Lm5PJlAUxaoD2BttY3z9U5hE
         +HQg==
X-Forwarded-Encrypted: i=1; AFNElJ+nUmNCEZ9Uxo0GTMubTDFW/P3RtR5Wmu26/u5ZBUlr/MY78KmdLXmkF27MNsM0Lt75744=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHRZn0ew/b/Nv011xiy5JpLEc+166veieupFn6xwlulovgfpYM
	g7gOA5bEEBeA8BX9uNufV98/HtaBYiBdIZGNm72+lSqr4TxOtBka+MZIYWT30uSlwLI=
X-Gm-Gg: Acq92OFxcAERy1R18bRyI+Evqn5kQAEeLRQlpiVoUvIL71e6NPiBdr8BAYi3xGKcyK5
	ehktXOeGw0UtYO7sEVmfDyoO8woUmsG6Pcjih6cYhVepkujM2Vz1o+nVeuQiduBn4XlBFOB6YGj
	++FhvBpg2kDAf4d/krknDdIhH/umeuvOueaEia8dKavKSpn2mRZcBAeWLKjUYOqvQcHMXNZVPQl
	wiOf1KG7zeHLg+jcuQl5gvac1xwVrZ9k9HGgBkYbQCafnq0n09gD+eZIJc15mIXKZIC4j6VHi+E
	NsQNQGfdNWrHwgbmbc8pu36Ku2lfk4YwvtdXHdujTh2lYTUPbzFarCA8u7i0yrI7zdCT7if7JT2
	shDU3C/VY3lnqw2IJ0u169xXH0cpTkHeHehSBRyz7pFO8WdAnlN6+l9jOs6YwLqZH7ckxxj/ChQ
	xThxfvJ+T9Ja/WWPI=
X-Received: by 2002:a05:7301:168b:b0:2be:833c:149d with SMTP id 5a478bee46e88-304491e11fcmr2091389eec.28.1779470020197;
        Fri, 22 May 2026 10:13:40 -0700 (PDT)
Received: from localhost ([2620:10d:c090:600::69da])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30451f3feadsm1872911eec.13.2026.05.22.10.13.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 May 2026 10:13:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 22 May 2026 13:13:35 -0400
Message-Id: <DIPDH3PCUDDG.EGYL0SYSG1IO@etsalapatis.com>
Cc: "Andrey Konovalov" <andreyknvl@gmail.com>, "Alexei Starovoitov"
 <ast@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii
 Nakryiko" <andrii@kernel.org>, "Martin KaFai Lau" <martin.lau@linux.dev>,
 "Eduard Zingerman" <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>, "Song Liu" <song@kernel.org>, "Yonghong Song"
 <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>, "John Fastabend"
 <john.fastabend@gmail.com>, "David S. Miller" <davem@davemloft.net>, "David
 Ahern" <dsahern@kernel.org>, "Thomas Gleixner" <tglx@kernel.org>, "Ingo
 Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>, "Dave Hansen"
 <dave.hansen@linux.intel.com>, "X86 ML" <x86@kernel.org>, "H. Peter Anvin"
 <hpa@zytor.com>, "Shuah Khan" <shuah@kernel.org>, "Maxime Coquelin"
 <mcoquelin.stm32@gmail.com>, "Alexandre Torgue"
 <alexandre.torgue@foss.st.com>, "Andrey Ryabinin" <ryabinin.a.a@gmail.com>,
 "Alexander Potapenko" <glider@google.com>, "Dmitry Vyukov"
 <dvyukov@google.com>, "Vincenzo Frascino" <vincenzo.frascino@arm.com>,
 "Andrew Morton" <akpm@linux-foundation.org>, <ebpf@linuxfoundation.org>,
 "Bastien Curutchet" <bastien.curutchet@bootlin.com>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>, "Xu Kuohai" <xukuohai@huawei.com>, "bpf"
 <bpf@vger.kernel.org>, "LKML" <linux-kernel@vger.kernel.org>, "Network
 Development" <netdev@vger.kernel.org>, "open list:KERNEL SELFTEST
 FRAMEWORK" <linux-kselftest@vger.kernel.org>,
 <linux-stm32@st-md-mailman.stormreply.com>, "linux-arm-kernel"
 <linux-arm-kernel@lists.infradead.org>, "kasan-dev"
 <kasan-dev@googlegroups.com>, "linux-mm" <linux-mm@kvack.org>
Subject: Re: [PATCH RFC bpf-next 3/8] bpf: add BPF_JIT_KASAN for KASAN
 instrumentation of JITed programs
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>, "Alexei
 Starovoitov" <alexei.starovoitov@gmail.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260413-kasan-v1-0-1a5831230821@bootlin.com>
 <20260413-kasan-v1-3-1a5831230821@bootlin.com>
 <CA+fCnZf-o8tiv_tX9YB5eBUGx17OpztKZsEB6Awjw3WAqBAiUw@mail.gmail.com>
 <DHSWSSYRPUVC.2W3G3OU27L3HG@bootlin.com>
 <CAADnVQLj=UosnsC-4V2+mN92Fe0-kW++U+m-O9c93kk6BwiXgw@mail.gmail.com>
 <DIP9O3BEWG3C.2BAHKYUIA4H4E@bootlin.com>
In-Reply-To: <DIP9O3BEWG3C.2BAHKYUIA4H4E@bootlin.com>

On Fri May 22, 2026 at 10:14 AM EDT, Alexis Lothor=C3=A9 wrote:
> On Tue Apr 14, 2026 at 4:38 PM CEST, Alexei Starovoitov wrote:
>> On Tue, Apr 14, 2026 at 6:24=E2=80=AFAM Alexis Lothor=C3=A9
>> <alexis.lothore@bootlin.com> wrote:
>>>
>>> On Tue Apr 14, 2026 at 12:20 AM CEST, Andrey Konovalov wrote:
>>> > On Mon, Apr 13, 2026 at 8:29=E2=80=AFPM Alexis Lothor=C3=A9 (eBPF Fou=
ndation)
>>> > <alexis.lothore@bootlin.com> wrote:
>
> [...]
>
>>> >> +config BPF_JIT_KASAN
>>> >> +       bool
>>> >> +       depends on HAVE_EBPF_JIT_KASAN
>>> >> +       default y if BPF_JIT && KASAN_GENERIC
>>> >
>>> > Should this be "depends on KASAN && KASAN_GENERIC"?
>>>
>>> Meaning, making it an explicit user-selectable option ?
>>>
>>> If so, the current design choice is voluntary and based on the feedback
>>> received on the original RFC, where I have been suggested to
>>> automatically enable the KASAN instrumentation in BPF programs if KASAN
>>> support is enabled in the kernel ([1]). But if a user-selectable toggle
>>> is eventually a better solution, I'm fine with changing it.
>>
>> Let's not add more config knobs.
>> Even this patch looks redundant.
>> Inside JIT do instrumentation when KASAN_GENERIC is set.
>
> (with quite some delay) I think it would be better to keep this new
> BPF_JIT_KASAN, because aside from the possibility to use it in
> bpf_jit_comp.c, it allows to update tests affected by KASAN
> instrumentation in a nicer way. For example, the test_loader subtests
> that monitor JITted instructions are confused by KASAN. I can either
> skip them or make them smarter when KASAN is enabled for BPF, but in
> both cases, it would be nicer to just adapt the behavior based on a
> generic CONFIG_BPF_JIT_KASAN, rather than sprinkling some "if
> jit_enabled AND CONFIG_KASAN_GENERIC AND ARCH_X86" in selftests. That
> still does not make it a config knob, that just creates an internal
> Kconfig option that is automatically turned on when KASAN and JIT are
> enabled at build time.

Having a togglable config knob gives us the option to set up KASAN for
the kernel but not for BPF, and I don't see why we'd want that. Imo we are
already paying the cost of KASAN for the rest of the kernel, there is no
incentive to not run it for the BPF JIT. Having to eat the complexity cost
in the selftests seems reasonable if the alternative means a cleaner
interface for the user (preventing them from choosing an unreasonable
combination of options).
