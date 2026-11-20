Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795196336;
	b=qBZwHdkFdbhqBDNGazGaFcbLVApNZOJw9swv8SOVUW3EK38rWuVpRRyWtPn5lVOvhkZL
	 K3VrUuLdobwN5kZsmv2HBIfIObjHVkL5boWI+U6WWrcTR/jZ/A7jo3cO+xm96pjKse/lr
	 FsSbBY38I8pCJwTRYEZTlmtPneVUnCZtwG3K2AAs55KZtFoedfTNxkEjxsMKvf6rC3Lus
	 QbZpggjdUzJd9BvBYdINPSzmbpyr6Bw78S/lh2eDtccKGRlsgWBxKZj9uXLZ+gbBWkW3k
	 7QCnUnUJL8pG+A2glwcL5zVnHRxWagXp14YigTsW8NjwQ3n1GJ92SPAmxGTWaSFYTSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795196336;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 Cc:Subject:From:To:X-Mailer:References:In-Reply-To;
	bh=KTQmlFfwUQU4v+NLA+yUDpQoUdLsc1gGPYlZIjQ7eEo=;
	b=r73N/yTWvq/0Q8c8UmA38GMerTlJHslzjSvo6sZfkrVQkJQpgAS0+H/zTYrFLkrjmJol
	 kzxv7zm+JJUAmyEiCGPcWUL9/kndSHNLR4V/4Kud+70TY2lncMNo1e/kfwWqFuAIP+hKJ
	 U7rUkXv+32tRmtix1IGW8+lTQYIejU0AW+RJbjSJi1vxzQCdkjYbugM28uynIeNQkJ9WH
	 T4sIvM18y49RQnkkovA/jvMwcn9siA/BxlWvDS0GxV8YVPquQp51cAGhkX+yJAYadrSz+
	 u3gk1EvtU65E41BIuJOL4tBVnD03K6gxcJchAzXEheMLn9veQh9feKdT2cYi40f4MAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZLqTU0I+;
	arc=none smtp.remote-ip=209.85.214.182
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA2A606A325
	for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 17:38:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ABA2A606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZLqTU0I+
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2f04f61282dso3406125ad.1
        for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 09:38:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795196335; x=1795801135; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=KTQmlFfwUQU4v+NLA+yUDpQoUdLsc1gGPYlZIjQ7eEo=;
        b=ZLqTU0I+DIIHMin65pUJcuDQgDfSkiYKNkHSq8jQ2W1y3uMQaQPbei6+eu81GWf6Vn
         KfMyIv597LZ5FDfOmkRrYz6QA5ZVwklvvIkdS7QUpmDkbyA4nTtBRgXM72IXzfhAeP3W
         KnXGCWDrVBPaNcPYgQAPiwVRHiH48IWIP4jw1/pM35UI3IiPlG0O/c4k4O0yd7gbNsM3
         81YCSm6zO16/6p/yt98D/h0Isr8KQ5k2zBEa5m6cdNPqxQX18ZHqgxKDzVTvmtpZsmkT
         zbZ6YQPYIEQu+Y/TT7Tm7ujj3OxJ1vOEgM4VTNcKBV5LHzJ3MjXuqmaRaP2FvG9ghfN/
         ec8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795196335; x=1795801135;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KTQmlFfwUQU4v+NLA+yUDpQoUdLsc1gGPYlZIjQ7eEo=;
        b=L7uFgohwrNk/bQgTRC4cDIZ26+B1KBGhOnKDWRGZJ2etfxGCwa//bzZ/H8P/PWYdMe
         Rpm67pcZirv3GS/eLET3LLED0T8/38qR5r7/dRfS2eJpFf9gCiVB7rj/EKozDlxUmEol
         N0Vc7cWH8fv/dH7VCmSAiiS8YbVqnpqKFTJPl/2N1JiDwIvJKdeBRApoF7RIfhkLwKvQ
         uU2zmGYWrzYZWIg8oaEdO/sZCpso088LKMd6qd5Qe4Yh47wKpsEH+lgKuf070a9mYb5q
         Dx9eJzlD/vhZwAnz8IfeXRKl6id2eXn33jHhB/tY2/nlL4GgOVuQG2WVDZBYbqyMkh1y
         cKiw==
X-Forwarded-Encrypted: i=1; AL+hErFqfF4rspR83bAEPDShG1EQ2DuQnf/dYgvezoMZiRDlQTCwPQb5bbTGK5VWsKpJb3bUVug=@vger.kernel.org
X-Gm-Message-State: APuU4Z8/tOdkNsu3MWEsRRoWNY1P+al5J4XPWo+xx5FfuWld3+ldWa3L
	43z7XUzXviiQPON+MqsgEo9MEBj2BYmYOt2GZlZY4qgb83uKIU+bHiGv
X-Gm-Gg: AZFdTZdTwHwF9n4L4LYAMCldWhps0kn4tAVH/Wu8ZKqVBysf8T13iuDiZ4deNNsbf3P
	hkN0hIwwlMxpyGY7pYYklu+A5HvKh1prx0jyZ5csOMdOfVcFhPI7dALkNzrlLZqhS8Mfy1ZR8RG
	hcoj4Q1uUE9c2KFSEIlvDXO/aa8r4HUDj4X10KpGSpuKchO26/ej6V6mM07jPMG2WrV8OZJAh/J
	XxkeXStygD44laFrUZo4XT+LYQj9ZBbUryK0cyylClqXzhYO9ZT5+x6qmOPZUAYihazBHkzftZ2
	QHfsmxonUmm5IGUFM1cl9PRHyYn5ZdAtd5HzLGOIjefF/E+yxnvry1X6iYCyGv7d93+wH+cH2tv
	OxirPLS87glgQDx0zQTinCt3FbZBZFjUdpnmW0Pcv1/irmf98vAAk4XLp/WAdkuUx7iDMHc0fI8
	ZpXUeUpk0wboE3SH5l05FAveKDHHlUZEBBC+vd2f2e+wUwAz1OuzXxsvcQ9J38exScs111q0Pyz
	YkQDkoAOilY9BjeFpnnM2xVqlKZ4hngtBG1jpbi3n+d8Lt6omjPs82/qMSRrGufi1fBSpWfIJAo
	rlr6/KvypeMXP54qPYNmUZNIOtIyph1hSTR6IuGW2YUf2TNA3WZJvcAR4TiEO0jbZVvxt69F0wr
	GerILZv1EGVUq3huHRdWn424PHZ/mlwoGfA==
X-Received: by 2002:a17:903:2391:b0:2ef:f01f:fa4d with SMTP id d9443c01a7336-2f03f1e0f73mr43801925ad.51.1795196334841;
        Fri, 20 Nov 2026 09:38:54 -0800 (PST)
Received: from localhost ([153.61.198.247])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03f0dc4f2sm18100965ad.30.2026.11.20.09.38.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Nov 2026 09:38:54 -0800 (PST)
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
Date: Fri, 20 Nov 2026 17:38:53 +0000
Message-Id: <DN07ZMOAD4GP.37PG3XUPBG4CM@gmail.com>
Cc: "Ryan Roberts" <ryan.roberts@arm.com>, "Will Deacon" <will@kernel.org>,
 "Mark Rutland" <mark.rutland@arm.com>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "John Fastabend" <john.fastabend@gmail.com>,
 "Andrew Morton" <akpm@linux-foundation.org>, "Alexander Viro"
 <viro@zeniv.linux.org.uk>, <linux-arm-kernel@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
 <stable@vger.kernel.org>
Subject: Re: [PATCH v1] arm64: Mitigate Spectre v1 in the BPF interpreter
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Catalin Marinas" <catalin.marinas@arm.com>
X-Mailer: aerc 0.20.1-355-gf870624f6c37
References: <20261117172341.3152407-1-ryan.roberts@arm.com>
 <DMYSI3BOQWOC.2P2FZB0H872DR@gmail.com> <awAay4FFj1_wQtaL@arm.com>
In-Reply-To: <awAay4FFj1_wQtaL@arm.com>

On Fri Nov 20, 2026 at 10:02 AM UTC, Catalin Marinas wrote:
> On Thu, Nov 19, 2026 at 01:18:03AM +0000, Alexei Starovoitov wrote:
>> On Tue, Nov 17, 2026 at 09:23 AM Ryan Roberts <ryan.roberts@arm.com> wro=
te:
>> > The arm64 JIT implements BPF_NOSPEC with a speculation barrier, but th=
e
>> > interpreter calls barrier_nospec(), which falls back to a no-op on
>> > arm64. Programs executed by the interpreter therefore lack the
>> > Spectre-v1 barriers assumed by the verifier. Contrary to the code
>> > comment, kernel-wide SSBD does not provide this protection, since it
>> > mitigates Spectre v4 rather than Spectre v1.
>>=20
>> Nack.
>> In bpf-next arm64 has no interpreter when the JIT is built.
>
> And what about current mainline/stable or when one disables BPF_JIT
> explicitly? Should we force BPF_JIT=3Dy as well when ALWAYS_ON=3Dy?

Anyone who didn't have BPF_JIT_ALWAYS_ON=3Dy were exposed to speculation
attacks forever. The security hole was wide open. We've been saying it
forever. At the next merge window we will say
"you cannot make wrong choice anymore".
