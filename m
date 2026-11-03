Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793731861;
	b=VpAnrmDGVVDOlb6DnAqs4tLpPaFEbpGwfwmvS6UED9+ynsP5kkNHOPSdxrwl9Q7PFT/E
	 SrA4rJSwoafBlgbdyLinrD0Tq4jsgeDqseEAs2239RhlP6Wtj6dPnVVwu9kqZch+cOqAY
	 xSU5cIO0W09s3wh1oiktwnj2taLGfkhm9k5nf81StN3tpV3fJCQU32/w3YKg/vm6Iy1kj
	 kEweD0eWU8J6GNvnF5OGZom+KEeUs+x24fLjQh9C4VZA2DFHfHrIEquYCskOLHCy/8Wyr
	 MN0B7HlX9ZFnVf2GW5qU8SDnKAdk0Kxbcf6aVMxtTGSJSF/54ls5Ef8f1o9qPmV6jFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793731861;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:Mime-Version:
	 Content-Transfer-Encoding:Content-Type:Date:Message-Id:To:Subject:Cc:
	 From:X-Mailer:References:In-Reply-To:X-Last-TLS-Session-Version;
	bh=SV3j1/NOB3cqz5PgTb/kJewLkVW1H74At45X3b+EffA=;
	b=MCYqlGipAmFAtmX4Tdrl3WMEHKvGHXp6DXiihotukxErY5egtocH1IPy9xfGGzKMTZOr
	 737iz49RSU6PxEsurhIUD3Z43XgUy/PW6nTw8h4LYB+mAlcfdPIBYnfm4jQU/dOplqjaf
	 eshh792nRZxYjB7P7jgvomZrSAN6B4XsPH1DzXHMtQFr5cQ758YQg7r2K4ECip4HfIdCB
	 yhCaiioP9m0ZvfJNKunmwQHy+pFSx+fpS0AOdWhQuETqtJOrBIdaNjFjyxXie1yjYu88L
	 G8a/bWZop/nVi/IS4TigW67hY3DngRqOHwWk0hmTPDRMsaA57Fo8ShxYnzGf14QFc2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=BFRa0cTW;
	arc=none smtp.remote-ip=185.246.85.4
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33536606A326;
	Tue,  3 Nov 2026 18:50:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 33536606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=BFRa0cTW
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 7478B4E413DD;
	Tue,  3 Nov 2026 18:50:57 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 3F6F56046C;
	Tue,  3 Nov 2026 18:50:57 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B8973103291D1;
	Tue,  3 Nov 2026 19:50:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1793731852; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=SV3j1/NOB3cqz5PgTb/kJewLkVW1H74At45X3b+EffA=;
	b=BFRa0cTWbki2shifQuuZaeD36FTwQ7JoMSjmkZp/J3DN9jcUQ4QurPyQznbB4tYwMQeg16
	LahZiXeWIdTXdxfihVcLs3ER1tudijCn6XE7tzQ1Q1Dr745sgxUJHc2TDK7SGrab1nr02H
	Sb1BggmG71T5TTLPnuwv6X4FGYSQpXJ7VJy8lz9XmDwOZuYK3mBeHZnIkmoDmsy36hXGCW
	aQDGcnIZkhpVEoQ2L7y7w+rzt6jlgrDA6ilZybQNx/GPdZI5bgW2eVdg8j65MWPtAnlv2k
	8sLxzv+6pdMIDUSFLFmVmKhvBhYBoU9wqsGe0VfUc/CPVbBSTaHlTfBiQmJpHg==
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 03 Nov 2026 19:50:46 +0100
Message-Id: <DMLSVEMJA9UE.2H7ZSBBU81XVS@bootlin.com>
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>,
 =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>, "Andrii
 Nakryiko" <andrii@kernel.org>, "Eduard Zingerman" <eddyz87@gmail.com>,
 "Ihor Solodrai" <ihor.solodrai@linux.dev>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Kumar Kartikeya Dwivedi" <memxor@gmail.com>,
 "Martin KaFai Lau" <martin.lau@linux.dev>, "Song Liu" <song@kernel.org>,
 "Yonghong Song" <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>,
 "Emil Tsalapatis" <emil@etsalapatis.com>, "Shuah Khan" <shuah@kernel.org>
Subject: Re: [PATCH bpf-next 0/2] selftests/bpf: port test_ftrace.sh into
 test_progs
Cc: <ebpf@linuxfoundation.org>, "Bastien Curutchet"
 <bastien.curutchet@bootlin.com>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>, <linux-kernel@vger.kernel.org>,
 <bpf@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
X-Mailer: aerc 0.22.0-0-gc2f86b7abde3
References: <20261030-ftrace_in_test_progs-v1-0-aa50c5dd1ccc@bootlin.com>
 <DMJE6776F9F0.1O5A9ZMKWYEUP@gmail.com>
 <DMLGLCFQW48J.334XR00MX6V0T@bootlin.com>
 <DMLS3TW3RYF3.230ZHPCINZ0N6@gmail.com>
In-Reply-To: <DMLS3TW3RYF3.230ZHPCINZ0N6@gmail.com>
X-Last-TLS-Session-Version: TLSv1.3

On Tue Nov 3, 2026 at 7:14 PM CET, Alexei Starovoitov wrote:
> On Tue, Nov 03, 2026 at 01:13 AM Alexis Lothor=C3=A9 <alexis.lothore@boot=
lin.com> wrote:
>> I initially went with a ftrace instance, but I came back to global
>> ftrace because graph function filters (set_graph_function,
>> set_graph_notrace) are not handled at instance level, only at global
>> level. But maybe setting only set_ftrace_filter and set_ftrace_notrace
>> is enough for this test ? That would indeed simplify a lot the setup.
>
> Yes. set_ftrace_filter alone is enough.
> The test needs function_graph and a trampoline on the same function.
> set_ftrace_filter of the instance does that.
>
>>>   all functions are patched       only the filtered functions
>>
>> Are all functions really patched with the current series ? It is still
>> applying filters.
>
> Yes. All but the ones in set_ftrace_notrace.
> Only set_ftrace_filter and set_ftrace_notrace decide what is patched,
> and set_ftrace_filter is empty in the series.
> set_graph_function is a run time check. Every patched function calls
> into fgraph. Then graph_entry() -> ftrace_graph_addr() drops the ones
> that are not below bpf_prog_test*.
> enabled_functions shows what is patched.

Ah, thanks for the additional explanation and the enabled_functions
hint!  That definitely clarifies something I've been struggling to
figure out.  v2 in progress with your suggestions.

Alexis

--=20
Alexis Lothor=C3=A9, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

