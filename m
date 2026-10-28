Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.225.137
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793153730;
	b=R4tnItZ9bMxByo7r7Bw0x6Gx5wJ5oFCgIeebG2I5yYDtALjZCfoy9hnTUsSax/Qtfaq2
	 34HeO/6f+OiLw4b4eKSg5YkRtz67kcxRaF3bfpFKkFOgxYYiDLeAI7xxJ/smLwpGyI3DX
	 Lb30RB+rZYm1j4PNbw0IT72gbYmOi5cG/22TfLMiUoMgr4b+3o6kVBe3ZKbGeSlLRarP1
	 1a7vriWuEofi4FuF4SzGtfdkPQhKYwxkWD4b3I00fY/p/iOF9Z/7yhd+9ObBFBWEtSZ/V
	 /TH/CrmBP0bkA3LcoWUfS2rjhjDelBRhgb9w8RE1pQUwA2mJCBat0ZppR7Gw/u6POgQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793153730;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=VCWn7vikuko6GduGmwqYjNeyExDWwE2i/+p67qQrM6o=;
	b=zdLXB+oraAs2Y8PP3A0x+3m+g2a259z1BTbqJiYozKEO9E0VYmF1kZKpoKYrHfICvvDt
	 2utYDsuJEGYeojMofVLsj5qUUqgsSYh+sUIDr2cKmAN5jZx4phhjU9kFvmqk7ed8v4Csj
	 zCr5uQSe3fEzn7iQF+jXDwJqRKK5C2X1Lktmv1UZM2w96RN97nariJdbA5w8j9a0tVBGu
	 w+fzbIsJFOaj0mNPGdwv13zSiKbAvcTEANvtDZKA+uilR7Fe4l7wGw/N2mXjBP6gXllFO
	 8a5gqgIFboj7UIAJFg+9GQ3jXkVbNon7l2Bdw6UHsqjO5kUKNqIUgp90u9UBd7Y1tnA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PbAKMIO4;
	arc=none smtp.remote-ip=74.125.225.137
Received: from mail-wm2-f9.google.com (mail-wm2-f9.google.com [74.125.225.137])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E17C7606A31F
	for <bpf@vger.kernel.org>; Wed, 28 Oct 2026 02:15:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E17C7606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PbAKMIO4
Received: by mail-wm2-f9.google.com with SMTP id 5b1f17b1804b1-49e6eb11e9cso1978585e9.1
        for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 19:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793153728; x=1793758528; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VCWn7vikuko6GduGmwqYjNeyExDWwE2i/+p67qQrM6o=;
        b=PbAKMIO4jtmhksZmq6teWQ8BcxDsAFz2iTtIMmjIwi7sjT5oobGg5tUqn1qr2QVWjt
         ZhbLX6KzOx61B52/xJSqSgvRQ+XIi2gOZXFwYukY5Eohg7QetUmzNVCuXKEyu1yA5kl8
         qktmicfXUVvwBPugZcKjiKLI/GbTFUkZKuC5tXUqkGQMQwg1zMUPHOJQpsjQSIc1kkgW
         APWHpWf6HofEjrW71WKrtvmYGAXzd7E49/iPybv1DcHrUDOvjxUQYPaEv/GCiRhgZ/Jz
         mfYldm52gNRet6J1LwkALT8TuwCJmufhW/31HzoWAvYZRyzgD/tPDrMRzsJBltPCVTAw
         /Yqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793153728; x=1793758528;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VCWn7vikuko6GduGmwqYjNeyExDWwE2i/+p67qQrM6o=;
        b=jUkFbU1M7IPq140oVSLizc0EA8Y8mIN/o9OZYx+1AHnSvEIfxAMv2lpP8PNJwKToZv
         jggfdzZ8/nXtVaCrZ7KBIoc/HJ9Bht5iHSZ6X0LKD5txztn7aV7J/JGfOoO6xMlfv4fG
         /hKzwH+TCT1okaDEFOxndM5pMgJlyG89Kjc9VAJGDftCAuJUR8g2tC2PyXM2Ppq5FY4G
         zxzkF/3Bv9w3mEs4A3dA2ahY80Lu4dGxPj++ndFhAx4AXEGbk/gqXcBDJGHAyZn6J4Dn
         8cs2XspsCmMPFyDQTLjX2Hi7q1qCSfGGCjeQlWHV9kgmC/RuHV+B86DnKkNJRBqpRFsL
         yvfQ==
X-Gm-Message-State: AFq9FYLFVj0MIekchishyTtJzoO9XzOsmFksc0lDgZWMlzUCW0VqVqEO
	lyCSEjt7FJsJ9HS++/gXI6qaXlFkLAUsQsQNS1eHe95hp/LZwAq9nZ4g
X-Gm-Gg: AYBFou1o9TLPgmEJQErr0kezwvYa9aBy9fAbmopFqUgDhSoRFeX+vQ8jgPM9w9bbiYr
	KdEnkD4+eHGUWTYmglsE+xeLLWmg61YNktoIzomqc9DYJwclDXLZO3nE4SamLsRx4s89PTLrJVe
	KoTMbwznoaBlizhaIAS/xesr7pOvb1vn5USnZ+wp96x6Abq9RvJx/Nuv6/PkXruWp9u/KJ3Vl13
	AAz5kNJKMR6bhDNxBsY/uzTqyuvJ9H8RaRAWf0KRbn8UysJ8be+//IiAJkl4OMvZDx43/oWMbvV
	mfR2iJAWjvahINZ8boC+Mb+KH5+dxyZwYsV87QkqY/0pYFNs1kkqhHBr+UiKT3to+AxOrhmF0zU
	M3LkiczYVShGBmEKHCUcbAwKymaCHs5oK6JIGuFt77IGz6BHaRSavPBER39LIi0p4BQhfneO1vc
	FiE1+5x9XK69YJW/Khz5CnLk4A0o8R1gtWsZnT7ESJIumDEHAw/dLFODv1JoRgnwoVOzOJHSNfP
	LuQElIM3CKVXURILph4ANIes0Qt63jKVJmzYPLzSRJTcueNuWlHcoQB1lZb6v4gNuOKc/C0u7oR
	5QKXT9QDJRxaG1ZkqY34FM+ZJD93fknFqim3JjvttE4jwkOSn4+gKvULhnDku8GHJm6FQJP8WuC
	rHCSWaLH22dLvLmgJY1MjkgtqDkbo+hgdAc790jGI/vVvqhDSWfXXk3eUyeBXHAxd/Me+
X-Received: by 2002:a05:600c:154d:b0:49d:34:420d with SMTP id 5b1f17b1804b1-4a967202a2cmr14096205e9.20.1793153728345;
        Tue, 27 Oct 2026 19:15:28 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e4115f496sm24606506f8f.5.2026.10.27.19.15.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 19:15:26 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	kkd@meta.com,
	kernel-team@meta.com,
	martin.lau@kernel.org,
	yonghong.song@linux.dev,
	mason@kernel.org
Subject: Re: [RFC PATCH bpf-next v1 10/11] selftests/bpf: Test callbacks that unwind
Date: Wed, 28 Oct 2026 03:15:26 +0100
Message-ID: <20261028021526.1203900-13-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <6588701a3bed9893f94098c228cc7e451f323612c151ba676f712eac8bf80cae@mail.kernel.org>
References: <2fb53df72300b10ba5f5aff123c331b80a7c4be5.1793147364.git.memxor@gmail.com> <6588701a3bed9893f94098c228cc7e451f323612c151ba676f712eac8bf80cae@mail.kernel.org>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed Oct 28, 2026 at 2:25 AM CET, bot+bpf-ci wrote:
> [...]
> TL;DR: Selftests may fail instead of skip on x86_64/arm64 kernels built with
> older gcc (no asm goto output), where callback pads are absent: unwind_drain
> load error and the changed callback_unwinds message expectation.

Right: without asm goto outputs the helpers have no pads while the JIT
unwinds. In the next version check_cb_unwind() says -ENOTSUPP for that,
as for a JIT that does not unwind, and the tests skip on it; the check
comes after the one for the unwind_goto, so the message for a missing
unwind_goto is the same everywhere.

> [...]
