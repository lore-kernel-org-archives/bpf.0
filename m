Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB0744781C;
	Thu, 13 Aug 2026 11:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786620249; cv=none; b=WC68mQIe3OTFkV3kG6pXlzCV1BM2Pnu1ZPdF+vQHwy/1LvGao9HrUYL9jh0PUraZuF/WRpUmbj3SAHv3T3wx7WzvXI4nfUG5v85/8xzj30mpV+04ejV1sOG3dvM6Yd316PCF/Ps/HT/TDZTxsP+MbQMG+VEo199JKeIqH5lDdQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786620249; c=relaxed/simple;
	bh=Waq4pgCvVwRJAUL9X5bnLcV5KHYDXMUHIGf96+pI7fk=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Subject:Cc:
	 References:In-Reply-To; b=syeo0R35/4oQia4kPx4YoBq5VBh7P7Gz+/VbihkbEMyF9hNry25SM1nGBhFn1wwZvemo1InfgfZw10k1yhSLDgjoXUnhCbM+sCojtw9CfzzeR0kvYhgkvI9bH+4JFM/BZVPwUgmIB84dg09CEUGUPukWSXfepUnmaO8JoaMvdAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=0uNK9a7o; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="0uNK9a7o"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 4CBD14E411EF;
	Thu, 13 Aug 2026 11:24:02 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 1670B602B8;
	Thu, 13 Aug 2026 11:24:02 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 798EC11C4DC0A;
	Thu, 13 Aug 2026 13:23:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1786620237; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=HzK2CYqW5czY4icncUnZKjOwaKoQ+GfWN2/cIus5hEU=;
	b=0uNK9a7ovHQK3rheeEpn2Om7dM1YTJ8u9x/RJH7/dyitQt+cM/pD/U1zSKURTyZZh0NPdQ
	wXTPkMxW6DHah2Mb6X+Qyh06BWxJp04R/YqI+j3Czv0bpWo3iInzq0o8aO1gpzUOAISzOo
	nf+sJKXIwsn/ajCh85+LuNhOnr9EN5jAx53BcBoeHeWBbBaZL3VoJKIfKOUsM28MZQhfWG
	1rmKpOrrfiDneE2JBhy2PuNdPVJ92iQUBV5G7yYaPc9q/Nzuah/MrwF8MPtNJD/4b2+K5J
	5e9x91VKSg/r5vLPieh4NR5PKB2oExE5FVxM9/gdaRgFOdA5QFlx4L4o9cq7fA==
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 13 Aug 2026 13:23:51 +0200
Message-Id: <DKNS0JRAZM49.3SDUQBOEHME1A@bootlin.com>
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
To: <bot+bpf-ci@kernel.org>, <alexis.lothore@bootlin.com>, <ast@kernel.org>,
 <daniel@iogearbox.net>, <andrii@kernel.org>, <eddyz87@gmail.com>,
 <memxor@gmail.com>, <martin.lau@linux.dev>, <song@kernel.org>,
 <yonghong.song@linux.dev>, <jolsa@kernel.org>, <emil@etsalapatis.com>,
 <shuah@kernel.org>
Subject: Re: [PATCH bpf v4] selftests/bpf: allocate a larger timeout for
 connection
Cc: <ebpf@linuxfoundation.org>, <bastien.curutchet@bootlin.com>,
 <thomas.petazzoni@bootlin.com>, <bpf@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <ihor.solodrai@linux.dev>, <martin.lau@kernel.org>, <clm@meta.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260813-tc_tunnel_flaky-v4-1-3534df3fe930@bootlin.com>
 <5485fa0008f289c8cc299b9e382dfc12f275d92c82944d48dc4e311ee3d17409@mail.kernel.org>
In-Reply-To: <5485fa0008f289c8cc299b9e382dfc12f275d92c82944d48dc4e311ee3d17409@mail.kernel.org>
X-Last-TLS-Session-Version: TLSv1.3

On Thu Aug 13, 2026 at 12:33 PM CEST, bot+bpf-ci wrote:
>> diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testi=
ng/selftests/bpf/network_helpers.c
>> index b82f572641b7..dd33bcdf75d7 100644
>> --- a/tools/testing/selftests/bpf/network_helpers.c
>> +++ b/tools/testing/selftests/bpf/network_helpers.c
>
> [ ... ]
>
>> @@ -305,13 +313,33 @@ int connect_to_addr(int type, const struct sockadd=
r_storage *addr, socklen_t add
>>  		return -1;
>>  	}
>>
>> +	/* Override timeout configuration with a larger value for the
>> +	 * connection
>> +	 */
>> +	if (settimeo(fd, connect_timeout_ms(opts))) {
>
> A subsystem pattern flags this as potentially concerning:
>
> Both multi-line comments added by this change start their text on the
> same line as the opening '/*'. The loaded BPF subsystem guide requires
> the opening '/*' to sit on its own line for files under
> tools/testing/selftests/bpf/.
>
> The guide specifies: "Multi-line comments MUST have the opening /* on
> its own line, with the comment text starting on the next line."
>
> However, this file contains 8 pre-existing multi-line comments (at
> lines 455, 896, 1064, 1070, 1076, 1110, 1181, 1286) and every one puts
> text on the opening '/*' line; there are zero instances of the form the
> guide prescribes. Across tools/testing/selftests/bpf/ the ratio is
> roughly 1986 to 689 in favour of the style used here.
>
> Should these comments match the guide's requirement, or is the local
> convention the right choice for this file?

If the patch needs another revision, I'll use the opportunity to update
all the comments in the file before fixing this one.

Alexis

--=20
Alexis Lothor=C3=A9, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

