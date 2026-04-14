Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A46D3DBD59;
	Tue, 14 Apr 2026 13:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776172391; cv=none; b=Q3xEt0sW3yzqISrovUJInxB0zsjnGBssEXEEkFNuhGTlfsb0EMIWI+unStEQrCRpSM2cOZbq6FnX1FQfdd6wficfcrpEKdGy+ofR5GCDu6GEJJuiVTLb28QxaLhIJ+HJxtu7dI4UQeujKO4P13N6/dapNE1xeiAGr8b6huInHkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776172391; c=relaxed/simple;
	bh=ljtr9WPSUnaAjZD/FtGwji3II/sbFJuzXTsBaHKsQSU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=VTwHcUnvFP4GmhqDrufXjk3PJAewhNU7Tn/I6QyAIsNdYrkhVuIio762+e9Vmc6XxTjGZdyFFbW8qIjcOFFx6nN6g6JsHwQztlmgoKs9PryrtUPh18J+yyBq0WyIR2XV/A72VtHx1UWxlJoQcMexrDB34Hyd4BB3nfNm1gcInN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=lhDeNvog; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="lhDeNvog"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 8372DC5AA9F;
	Tue, 14 Apr 2026 13:13:38 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 46E3160410;
	Tue, 14 Apr 2026 13:13:01 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 569A6104500A2;
	Tue, 14 Apr 2026 15:12:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1776172379; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=ljtr9WPSUnaAjZD/FtGwji3II/sbFJuzXTsBaHKsQSU=;
	b=lhDeNvog7+cXfwfKejAzO+yVIre7KeKOh4nxhyYR84tw7Qhs4CDNLFYshF/sNo/ddcHeul
	OAXDnRRPYFfdKmNFr6FNXLWBgkwR5bSerHfi1jG3QAuxmeyq9DKVn4ADpvD+k/LktKcxCV
	Qo+C51KQYvBPk2tQWgzerrUX38wX8fl9mns5nowg6aBHUe0QUCDETlFcTsN3Vd+g6AhDW1
	t0+PPdVn0VXoKLO/NdWsu8xr8pa5SfFsPWlNHjagwF2HUg4Jwz/bTTtoEDbu5jNS5UXcqe
	/1a7m2ycQR5Rypiiam1nxF1Kid65dAD8mzMdsDqIpVAnb6rsDVnu+pzT2qXnlw==
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 14 Apr 2026 15:12:47 +0200
Message-Id: <DHSWK17EZUDP.GIJ6BX2NFR6U@bootlin.com>
Subject: Re: [PATCH RFC bpf-next 1/8] kasan: expose generic kasan helpers
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>, "Martin
 KaFai Lau" <martin.lau@linux.dev>, "Eduard Zingerman" <eddyz87@gmail.com>,
 "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, "Song Liu" <song@kernel.org>,
 "Yonghong Song" <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>,
 "John Fastabend" <john.fastabend@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, "David Ahern" <dsahern@kernel.org>, "Thomas
 Gleixner" <tglx@kernel.org>, "Ingo Molnar" <mingo@redhat.com>, "Borislav
 Petkov" <bp@alien8.de>, "Dave Hansen" <dave.hansen@linux.intel.com>,
 <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, "Shuah Khan"
 <shuah@kernel.org>, "Maxime Coquelin" <mcoquelin.stm32@gmail.com>,
 "Alexandre Torgue" <alexandre.torgue@foss.st.com>, "Andrey Ryabinin"
 <ryabinin.a.a@gmail.com>, "Alexander Potapenko" <glider@google.com>,
 "Dmitry Vyukov" <dvyukov@google.com>, "Vincenzo Frascino"
 <vincenzo.frascino@arm.com>, "Andrew Morton" <akpm@linux-foundation.org>,
 <ebpf@linuxfoundation.org>, "Bastien Curutchet"
 <bastien.curutchet@bootlin.com>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>, "Xu Kuohai" <xukuohai@huawei.com>,
 <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <netdev@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <linux-stm32@st-md-mailman.stormreply.com>,
 <linux-arm-kernel@lists.infradead.org>, <kasan-dev@googlegroups.com>,
 <linux-mm@kvack.org>
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
To: "Andrey Konovalov" <andreyknvl@gmail.com>,
 =?utf-8?b?QWxleGlzIExvdGhvcsOpIChlQlBGIEZvdW5kYXRpb24p?=
 <alexis.lothore@bootlin.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260413-kasan-v1-0-1a5831230821@bootlin.com>
 <20260413-kasan-v1-1-1a5831230821@bootlin.com>
 <CA+fCnZfubV6LgRjO3NQvhrG2Q5o0ftkFFupLWVYS50XDnmCaog@mail.gmail.com>
In-Reply-To: <CA+fCnZfubV6LgRjO3NQvhrG2Q5o0ftkFFupLWVYS50XDnmCaog@mail.gmail.com>
X-Last-TLS-Session-Version: TLSv1.3

Hi Andrey, thanks for the prompt review !

On Tue Apr 14, 2026 at 12:19 AM CEST, Andrey Konovalov wrote:
> On Mon, Apr 13, 2026 at 8:29=E2=80=AFPM Alexis Lothor=C3=A9 (eBPF Foundat=
ion)
> <alexis.lothore@bootlin.com> wrote:
>>

[...]

>> +#ifdef CONFIG_KASAN_GENERIC
>> +void __asan_load1(void *p);
>> +void __asan_store1(void *p);
>> +void __asan_load2(void *p);
>> +void __asan_store2(void *p);
>> +void __asan_load4(void *p);
>> +void __asan_store4(void *p);
>> +void __asan_load8(void *p);
>> +void __asan_store8(void *p);
>> +void __asan_load16(void *p);
>> +void __asan_store16(void *p);
>> +#endif /* CONFIG_KASAN_GENERIC */
>
> This looks ugly, let's not do this unless it's really required.
>
> You can just use kasan_check_read/write() instead - these are public
> wrappers around the same shadow memory checking functions. And they
> also work with the SW_TAGS mode, in case the BPF would want to use
> that mode at some point. (For HW_TAGS, we only have kasan_check_byte()
> that checks a single byte, but it can be extended in the future if
> required to be used by BPF.)

ACK, I'll try to use those kasan_check_read and kasan_check_write rather
than __asan_{load,store}X.

Alexis

--=20
Alexis Lothor=C3=A9, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

