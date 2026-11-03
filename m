Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793697221;
	b=bqtb7LlJjAM3oGv5ZMxjhZBWqBvT/sBX1GpxBrI5l/il7v+0YZgGQIjVFzIo+EuXaX8x
	 276xqlTS/7TyC/vnA5L/zFBAiQhcVLmpa5GnJcVXNQCZqlqOYJjeQp3ZE1DuJfRF6VBlL
	 jd1XyS4MR2fv/9sYBuiN73OpWMW74TO494x52SUK7Qc3GCm6QnqvVWQi0cqW/ClypQVZm
	 Hwspf0LY16+KOhSI1uK5QX69OKIoCHF8B04qdSJpHxVpffymYWUAbT7A2gryBD2uOzunL
	 WxZRGmV2fH/ZnO1QQlwvbZAi9QkL0dZng8aeqcUnkZ9QLrcdBbgXEul67kxiWT9jPWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793697221;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:Mime-Version:
	 Content-Transfer-Encoding:Content-Type:Date:Message-Id:Subject:Cc:
	 From:To:X-Mailer:References:In-Reply-To:X-Last-TLS-Session-Version;
	bh=vtVAKn63hZjF/xRzAIkMWt9nMX0J7jxb6ymkgZ0SCsU=;
	b=vSVpI6yKqQ8K9ycfWOM0ymj7xfg9p3/L6xuwJ/SeiMaBahzn0F+yk7zAq7Oz3HHt6pfP
	 oahcJ9lKspKWHX6AnEI4lLWS5/RNL9+PHETYfCo5Rj/mXfBuWMkllLAuwVh4SNE6GzVMq
	 LJBXTlp6RIcIY9EsgV0hZ1MSEohcR/XvRGt35wwMDpJhwOMu8V7IdtdPcHPSSLtEUD7JX
	 kgQ/KJBAGvwEmSNR+UqZUP44p7/7MDPjuCe/dbvQr8U6ZpYjmyb0Qa9JyW3GIFCXdWdUQ
	 It2vqz3d+EOzJyLO4KNOhbrcCKnJ/Rb4Ispw/8eNNN5y40HMTqVbqxUHz0QXbsW1haQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=cPq5+JP3;
	arc=none smtp.remote-ip=185.246.85.4
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E803606A324;
	Tue,  3 Nov 2026 09:13:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4E803606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=cPq5+JP3
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id C2A0D4E413DE;
	Tue,  3 Nov 2026 09:13:31 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 8E1316046C;
	Tue,  3 Nov 2026 09:13:31 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DD7FA103291A7;
	Tue,  3 Nov 2026 10:13:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1793697210; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=vtVAKn63hZjF/xRzAIkMWt9nMX0J7jxb6ymkgZ0SCsU=;
	b=cPq5+JP3kobZDqlYo39DZ+3Paj1cwtc/pvNC0LuBXLgLwwnSpM2mp6IUEDwhutPm1t8hqv
	n44j+7fSOB6IObByAy0qi5dP1QLN/hrCpek0/uV9rUhpBb5SP1likytMenSrorpctG28PS
	yoIwswHOY2tgefkrBvnwAElPtFDg3/CddFj5r4hL9DZphSne4tPmXX6qufxcGByRBoR4Kz
	ZVn7HI5Fjy1nn17IwfcwPdrtHS8m7C5rnxJSKFLAWAMbNLik0GATdnVf0nGsQm+TiKlKc8
	uVffO7L9pjgZM1IjeE5jfcryXlLKf9umc06Bh3mgGh+dj2k12v2Px/DfieIgKQ==
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
Date: Tue, 03 Nov 2026 10:13:25 +0100
Message-Id: <DMLGLCFQW48J.334XR00MX6V0T@bootlin.com>
Subject: Re: [PATCH bpf-next 0/2] selftests/bpf: port test_ftrace.sh into
 test_progs
Cc: <ebpf@linuxfoundation.org>, "Bastien Curutchet"
 <bastien.curutchet@bootlin.com>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>, <linux-kernel@vger.kernel.org>,
 <bpf@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>,
 =?utf-8?b?QWxleGlzIExvdGhvcsOpIChlQlBGIEZvdW5kYXRpb24p?=
 <alexis.lothore@bootlin.com>, "Andrii Nakryiko" <andrii@kernel.org>,
 "Eduard Zingerman" <eddyz87@gmail.com>, "Ihor Solodrai"
 <ihor.solodrai@linux.dev>, "Daniel Borkmann" <daniel@iogearbox.net>, "Kumar
 Kartikeya Dwivedi" <memxor@gmail.com>, "Martin KaFai Lau"
 <martin.lau@linux.dev>, "Song Liu" <song@kernel.org>, "Yonghong Song"
 <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>, "Emil
 Tsalapatis" <emil@etsalapatis.com>, "Shuah Khan" <shuah@kernel.org>
X-Mailer: aerc 0.22.0-0-gc2f86b7abde3
References: <20261030-ftrace_in_test_progs-v1-0-aa50c5dd1ccc@bootlin.com>
 <DMJE6776F9F0.1O5A9ZMKWYEUP@gmail.com>
In-Reply-To: <DMJE6776F9F0.1O5A9ZMKWYEUP@gmail.com>
X-Last-TLS-Session-Version: TLSv1.3

Hi Alexei,

On Sat Oct 31, 2026 at 11:54 PM CET, Alexei Starovoitov wrote:
> On Fri, Oct 30, 2026 at 11:50 AM Alexis Lothor=C3=A9 (eBPF Foundation) <a=
lexis.lothore@bootlin.com> wrote:
>> - commit 1 brings a few new helpers to manipulate ftrace from test_progs
>> - commit 2 performs the actual porting
> [...]
>>  5 files changed, 412 insertions(+), 46 deletions(-)
>
> This is quite heavy for a port of a 44 line script.
>
> Lets use a tracing instance. function_graph works in instances.
> An instance has its own set_ftrace_filter, current_tracer and ring
> buffer. rmdir undoes all of it.

I initially went with a ftrace instance, but I came back to global
ftrace because graph function filters (set_graph_function,
set_graph_notrace) are not handled at instance level, only at global
level. But maybe setting only set_ftrace_filter and set_ftrace_notrace
is enough for this test ? That would indeed simplify a lot the setup.

> What goes away:
>
>   series                          tracing instance
>   ------------------------------  ------------------------------
>   global tracefs files            files of the instance
>   save and restore, patch 1       rmdir
>   serial_                         not needed
>   all functions are patched       only the filtered functions

Are all functions really patched with the current series ? It is still
applying filters.

>   new progs                       progs/modify_return.c as is
>
> modify_return has fentry, fmod_ret and fexit on the same function
> and checks the return values.
>
> The removal of test_ftrace.sh stays.
>
> Instead of patches 1 and 2:
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/modify_return.c b/too=
ls/testing/selftests/bpf/prog_tests/modify_return.c
> --- a/tools/testing/selftests/bpf/prog_tests/modify_return.c
> +++ b/tools/testing/selftests/bpf/prog_tests/modify_return.c
> @@ -61,3 +61,28 @@ void test_modify_return(void)
>  		 0 /* want_side_effect */,
>  		 -EINVAL * 2 /* want_ret */);
>  }
> +
> +/*
> + * The same test while function_graph traces the same functions.
> + * A tracing instance has its own filter, tracer and ring buffer.
> + * rmdir() undoes all of it.
> + */
> +void test_modify_return_fgraph(void)
> +{
> +	char dir[128];
> +
> +	snprintf(dir, sizeof(dir), "%s/instances/bpf-XXXXXX",
> +		 access("/sys/kernel/tracing/trace", F_OK) ?
> +		 "/sys/kernel/debug/tracing" : "/sys/kernel/tracing");
> +	if (!ASSERT_OK_PTR(mkdtemp(dir), "mkdtemp"))
> +		return;
> +
> +	SYS(out, "echo 'bpf_modify_return_test*' > %s/set_ftrace_filter", dir);
> +	SYS(out, "echo function_graph > %s/current_tracer", dir);
> +
> +	test_modify_return();
> +
> +	SYS(out, "grep -q bpf_modify_return_test2 %s/trace", dir);
> +out:
> +	ASSERT_OK(rmdir(dir), "rmdir");
> +}
>
> pw-bot: cr





--=20
Alexis Lothor=C3=A9, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

