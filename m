Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 542E436C0D6
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 05:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790229320; cv=none; b=I0H9xSWevcD8PUeqK/k18jWL9fD4nTgwi8cQSIVrq3OWWIH+YIXaHAxg3ZNHUKD7vnOSECOvCInYAdMzOSLzP+BxZXJurdk5/mkOW8m/g6CzfaPiZGj4ClZKg74YlykmTSjDSIYn9HyBJfY4naxk7v1YkzymGuRijQu2gsswpTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790229320; c=relaxed/simple;
	bh=iT57O0JsvQT1oO/7SKdemLl2pW+BwJt0QPVuDng7JEA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Upu3/2N6Xn0RifIiFVOF+IyJeqyOhZkdWmqJCt9GD94Bv9cI0mw055tqVXVUuJVrgfnpK/MVGheuT95huzeQYxuMdltIYzfoJiv1NbZSgspUk8iywzt2BlTRoV7UoWc4RnCHOzSDnxlnGqESWXu4FvbZoiPWT6195QtHkbuGmRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EK1G/aro; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EK1G/aro"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2dd58e1e2c7so8781095ad.0
        for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 22:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790229318; x=1790834118; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=iT57O0JsvQT1oO/7SKdemLl2pW+BwJt0QPVuDng7JEA=;
        b=EK1G/arosKoqsglEH0Mtplm0NlN9XOtAZMlBD6M478r2mZDAqK39ogU0YRIFh4oOhO
         J6u2MkmKDu1R6IFfCfuKUhiXZ298c0Ba77sUsaH2Js0GCFdjaY0/1YQTey087fh8xqJr
         07/hXFBi9jg6qntXs+jshrRTClvZ0bMIqrTC9N4X86sbC75y2YJ6wNZJMNNZ2/eEqViY
         ZjDw8WYQom/hk/pu5RGchkJ6Ir32Z5+0DCEhuWcPkpIOPPPye6x1T/+NAE6lWhataT73
         1f9yoU4xuh+zSdCL7REMg4e1H8NPT8teSWgmAQGnrZ6TFJV/ch1eJWtSjDrYmv6y2pvj
         4TwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790229318; x=1790834118;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iT57O0JsvQT1oO/7SKdemLl2pW+BwJt0QPVuDng7JEA=;
        b=hMmaBeB1k6jZ0COkts7xnntKMkiSSGEen6KDv5V6JS0BIozSPTaow+vxcrYVfd9Y2V
         +Kdk3KhiW1v85JKzls+/gdhdaG3FcCWXcP2Eff56JNLbirVjzs0NPxR83+QufXyu4pD/
         9/Mx316T9QZGtfo487U79Lnipp+AnvFCWCY0Pyx5gSBrAteG5+UwkzwuN1tS26qRHJoW
         zF30c0ra6eeUWRnwSmOfOGAZrZXqMMIyJzaTeBHmGil3MPdKYZ+ItdGlcWDmOn9T1Efb
         tG2StQebfX9MNuopP/iaFG/Lf1atUAqemQ0TYOGX9L73h7MUNGqJU1ScrXQsUc2Dfdst
         XCww==
X-Gm-Message-State: AFuF++m3WDrrXf1XqvQL3PvBIpAdE1mUiw3/gZylkfs9ft1Vd7oqFB/T
	6Yfej6MiT1MLO/Tkjvh0f6Bwaj7rYK+8rlgs17XeeRwt6lJlZOLHDsFS
X-Gm-Gg: AYBFou2qnFl/e24j+X5ZdjxMcSn40nKUSsWbbbevHNn6HCCFhssoTXIXQe4LfKW4DP/
	HjhJwSITFtZ0XSqzDRwjw0mZx7R5okjE9etKgEbcCASlY71HeMSc1zrC/vLvdZqEygqT9chCrl9
	Gr6SGGXa5rj+H0K8/JZ7ihyoD89ATqRd/JsL7MOWidxUyU9CVEi3aJw/EGv4AQOBKIDCauutJte
	RIG8pFL+c3+x7WQIZxrnOaHqYx7IfrapTbv7183PKnpEItqy1Q5La4eIAP2T1y7cSst5o+YpTG8
	kuPlPciArqtU8wp9hYBlCFaU5I1GDZkf/rCghQ4WtWu1WNW8/7+j5rJrm/i99vaI8ire2M+dr1K
	YkHd47fBBUBlZpmuSZLpsmjWa14HlFVOVcu009++pBX8Kop9ots4rRZd/Oc4+RettL6p6RLvF0M
	tr73ETfG+HgRaBjhatBa+YaAta3sedSgmcKmZ88Py3SjGprxvvIyhV93cEcFVzouq+o0pHS7pq3
	XRKGutMvJ0WPyawOYjEJlDdD6o=
X-Received: by 2002:a17:903:240d:b0:2ca:6c8:abd8 with SMTP id d9443c01a7336-2df7da42900mr11739725ad.12.1790229318602;
        Wed, 23 Sep 2026 22:55:18 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df6d4910e2sm19383575ad.12.2026.09.23.22.55.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 22:55:18 -0700 (PDT)
Message-ID: <a913f2c69fdd3fa9ccf6df18b3e95fc880c0ea72.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 00/17] bpf: Indirect calls of bpf subprogs
 (callx)
From: Eduard Zingerman <eddyz87@gmail.com>
To: patchwork-bot+netdevbpf@kernel.org, Alexei Starovoitov
	 <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	memxor@gmail.com
Date: Wed, 23 Sep 2026 22:55:15 -0700
In-Reply-To: <179022901639.1337807.12766583921039284951.git-patchwork-notify@kernel.org>
References: <20260924031042.1690890-1-alexei.starovoitov@gmail.com>
	 <179022901639.1337807.12766583921039284951.git-patchwork-notify@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-09-24 at 05:50 +0000, patchwork-bot+netdevbpf@kernel.org wrote=
:
> Hello:
>=20
> This series was applied to bpf/bpf-next.git (master)
> by Alexei Starovoitov <ast@kernel.org>:

Well, that was not fair at all.
We agreed that I'll review this code today.
Anyway, if my input is not needed, so be it.
