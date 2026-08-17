Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 183733F58E0;
	Mon, 17 Aug 2026 09:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786960576; cv=none; b=VUSLIf5dz0LvYZUX2/tugNhpGbivQ2euIpHWmXybxzzHjKiQMxm+wa3cd3wFAIJSSPHITrDzNyE2t7uUVPy6Hj3QKJAx9Rnu5JMCIpLqm5hTaX8v/MWUVDVqoPZ+VGF4Eg0iakVyhB+Wg6lcF/vPdeeNyhiZjJrMfaJXSmhOgRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786960576; c=relaxed/simple;
	bh=VfSe1uHL6S/Q76hLZIUKNYTBfPpff6p6p3SFbFOifmQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Subject:Cc:
	 References:In-Reply-To; b=ufPvUcX1yBYbHMO8BL95aiXR4bOGmp4uoqiyBZXEcefw+vRq23Wax4ChaIQCCcF7gM3FzOOijXU6/SaOTSL9Tow+YKQTD7TcmMmIgoFHB5XPzWQ8/VbX6SZtpywve8VXDl+cLSee1ofYrbu0P5sSm+KvtBp+epLw5rv7o6AXFAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=dQt+Vp+l; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="dQt+Vp+l"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 8A5EF1A16DA;
	Mon, 17 Aug 2026 09:56:08 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 54F5560352;
	Mon, 17 Aug 2026 09:56:08 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BF3B511C4FFB5;
	Mon, 17 Aug 2026 11:55:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1786960563; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=mtBtSPmPjbbZ12kC6Vzxp1XkUgAFw6sD7320/XF8vpY=;
	b=dQt+Vp+lwaWW32G77vDmBmg76FSGrtVCWbyPEJyNMsyvFKIG0OGwjs6PzxaaFSds7dM1sz
	eePUFhPjfkQsYixH99ZuJB1+rqolqtwJ9YxsF9JCNX9+QFDdXt495t57u8vRHLUgKdwb2Z
	0TZG0iXgQpLhY4Y/mmAvF+l0AILGo3pHEK39+hS0AzqoujG/987aOGA5H1jnR0CZC/cgXh
	VGD4Gy1MeSCAIUW7UqrKebDfjm0SGKDbL9YVzU32P4kKctPwY/uLicS5C3GghHlv3CP80J
	q6H/6AKIIb2419e1yfZTkpMd7Wx0uSrOkATcVgNwW29LZ3QaCKejI3OziF4WNQ==
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 17 Aug 2026 11:55:59 +0200
Message-Id: <DKR4NFY9QWP6.HDPI329BNKZ0@bootlin.com>
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
To: "Daniel Borkmann" <daniel@iogearbox.net>,
 =?utf-8?b?QWxleGlzIExvdGhvcsOpIChlQlBGIEZvdW5kYXRpb24p?=
 <alexis.lothore@bootlin.com>, "Alexei Starovoitov" <ast@kernel.org>,
 "Andrii Nakryiko" <andrii@kernel.org>, "Eduard Zingerman"
 <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, "Martin
 KaFai Lau" <martin.lau@linux.dev>, "Song Liu" <song@kernel.org>, "Yonghong
 Song" <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>, "Emil
 Tsalapatis" <emil@etsalapatis.com>, "Shuah Khan" <shuah@kernel.org>, "Ihor
 Solodrai" <ihor.solodrai@linux.dev>
Subject: Re: [PATCH bpf v5 2/2] selftests/bpf: allocate a larger timeout for
 connection
Cc: <ebpf@linuxfoundation.org>, "Bastien Curutchet"
 <bastien.curutchet@bootlin.com>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>, <bpf@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260814-tc_tunnel_flaky-v5-0-5b93d030c42c@bootlin.com>
 <20260814-tc_tunnel_flaky-v5-2-5b93d030c42c@bootlin.com>
 <07776a9c-2998-4d65-af3e-c714181d4241@iogearbox.net>
In-Reply-To: <07776a9c-2998-4d65-af3e-c714181d4241@iogearbox.net>
X-Last-TLS-Session-Version: TLSv1.3

Hi Daniel,

On Mon Aug 17, 2026 at 10:55 AM CEST, Daniel Borkmann wrote:
> Hi Alexis,
>
> On 8/14/26 9:11 AM, Alexis Lothor=C3=A9 (eBPF Foundation) wrote:

[...]

>> +	/*
>> +	 * If the timeout configured by the test is different from the
>> +	 * connect timeout, restore it
>> +	 */
>> +	if (opts->timeout_ms !=3D CONNECT_MIN_TIMEOUT_MS &&
>> +	    settimeo(fd, opts->timeout_ms)) {
>> +		log_err("Failed to set timeout for connected socket");
>> +		goto close;
>>   	}
>
> Could you do one last spin? I'll get the comment fix applied, but the abo=
ve
> still has issues as pointed out by sashiko, so maybe this could be rework=
ed
> as follows (untested):

Sure, I was planning to respin today with fixes to issues raised by the
CI bot (wrong patch subject and mishandling of timeouts larger than the
default connect timeout). I'll send it later today.

Thanks,

Alexis

--=20
Alexis Lothor=C3=A9, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

