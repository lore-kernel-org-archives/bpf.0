Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795201604;
	b=XxHxkQ9XVJFoVYvX1K7v/1wprsCZ6uMYfhPY0xFgd1T+kt9iHtni+8WSfUIzM/z7J1KY
	 Ec92gxgJd+hvGbbv0C3SbA0JQ0o5+RPAurJZUgexkT9rAyP1PhVHtjeZg8AysVHhaQX4a
	 tSd2uzfEGHxUuTxEIS3zPYPUBXxLhecFA+xLyZYObGNP4qmga4H92stVjjSzvWusZ+uFw
	 aAuwA45aKVzYzVvbriXXr/HTqAdYVso6pTGTDCpqqIFjKQnT/cfdBZ1gTxx8xh716s2jN
	 xKhSQGpuj7WsBrFD6bqHCqkAP1x7DyNH7WwdRut0gmayaFJ/985cJwuXmFBTlIXbnXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795201604;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Subject:From:To:Cc:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=9QfCwv6q8iB9+8896+uv5bC3BHslVLQP8NmnilfJ2Qc=;
	b=iA7HFx4qBauL4Iea4BJ+NB6yHVQbv69k2P1lyBo1E2b9TW51V0zz3bYLe1hZe97K9Ife
	 ls3JiexDUEf5saVTekMvYO7O8zqJeloVlcX1Vc/y+VJOxAOJNtV+N2IX6JJos4AsfxPkC
	 UXj4XShgijMHlktbB0wPUfVcHbxbgQvm6LPHrneOIfg6XTO732CUw3XufI76Ckixmg0+r
	 SEPYNTrZsnJ2XDg/JY0H9zaZkxaHmC9FMwBSOQ7itaRAmJilqsfDYYgIaCi+OZs4FRXSw
	 8slNGtaZbBM9XSYhVUCoQHAiOn82IAdJVtDxmHB6/ldwK1ZbaBEVQBxLAZhjMPl1QBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rDsEEaoV;
	arc=none smtp.remote-ip=209.85.210.169
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5913960A263B
	for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 19:06:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5913960A263B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rDsEEaoV
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-8c70c2ab5a2so614331b3a.3
        for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 11:06:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795201602; x=1795806402; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:cc:to
         :from:subject:message-id:date:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9QfCwv6q8iB9+8896+uv5bC3BHslVLQP8NmnilfJ2Qc=;
        b=rDsEEaoVpoGF5GrKMVL83T+4DUsmLWwaxPxh/QQP0I76AxwjNRSBrN17TOAwnvtjgN
         aGJiM5gFKm4PRR7xzz1M51+5BNgZS+pOMcrSJEOsC1yHKy3lbEuAj+ipN0Mmtwwrdp0J
         fL7/sS3OBfIEriTYlzRyXBjRUF5IANPrT8dwImYQNp3Ca1E05Lykzw9O8TZcHS4AXFuM
         Eetzp6T0FSXtQIctMqOBQ/VfQRwzYiKNlAMFzUeimkG5jqCvFA9xZE8hBlIQb7tZN2hK
         pCoTiGViwfYTEEspTXrQu2cevVCBnfXkrRGbEG4Z6tUWo44I0QEal3Sg7NPENzYm37KJ
         hAGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795201602; x=1795806402;
        h=mime-version:content-transfer-encoding:references:in-reply-to:cc:to
         :from:subject:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9QfCwv6q8iB9+8896+uv5bC3BHslVLQP8NmnilfJ2Qc=;
        b=qImfmBnOFFCkevirlxyYRaYbolwIRqnOjct5IzXhfdgD4Axn4uK/XoGDXwF4Akb9vL
         ppvZV2TUOF2Jm6j7zia+aMLU7cxl9ECUx2nQ1ooF87FFVSW/3i8o2siXN9Ah57XG8Vkb
         5PpmtVVqcdGbDuI1UUFXY40GqmURgEO2uJE8T4NbmuryZew6T80ryUwcOUietZpNFX5t
         GZZiG4ERT3A3UY1Vyo3l29he5TUhdDUrDPfZBH181NUh71SmwPygtPvD5Euckh5jw5bK
         187CL8h+37nHQPI3AdNtfYec+l1zLrpRnr3j23vtoLFfckIn/4rV2ku30E4lKxNCcNDT
         slaw==
X-Forwarded-Encrypted: i=1; AL+hErGi+NgaFNjybax5Sx+It00IZEvbFGTA2XD0zTs/IopMSKjPrPvLYMEB1jZe0LNq/FhG7kA=@vger.kernel.org
X-Gm-Message-State: APuU4Z+5GsIZDotXfYJ8dBC+/jrlr1qk20Zw6/pNcPfUrAH14Mi9uRqi
	7/TQN4OdNgUFkRwigMhkq1YXOOZJAB1zdsNtI1ndAZ/BGccACRbkyhB+
X-Gm-Gg: AZFdTZe8MPOt/7KemDqPxe7DfIm6Hx0/RpKbsXHEHMgEbV1ZzSDbtCixAid68rQgyXb
	ZVL9oCCkHlGhfolOfPP1t/EW8zpDz1xG919/OBLTjZDZptt6OmF3jATnrEWGVsg36UBOMsd7Ite
	QgMWwjKxLba8RQxXZ1RP1ToxHFXlEPqJ9x96+b9+P2qQwRZt9CZNRAtnob+zR/z7J6DUCTWn6j9
	1DFVLVf/u5jj2vecKQM6Jbq08sPPGn7vwdC3GYMPxrGXuhaFFHyHKOFaJ8I7pzYG95CVXXr7zn0
	JUguQXzEt5Hzs/tawXyGLzi/mxKWA5FnK+sZiDjMlsnFL+FtcU7Iojx3DbiYAb1TfggBdle8vXq
	pWkQcwVTUxPoG1g/uuRT0Sf51ApB+AL4omhD3e3vVnhc9XMu3XBQwX8xIOpFeQi6X462TP0wI2q
	Q9uqM5cIhsV/8qTIGKUmN4z5lsklARRqUFbkjJndESpnklZpShdrjtxSu32eph+qckdWgwYq28o
	NRYDzSlHsvHtaLsSRnWchkyOluN903PgE+GRkWzFjfe86Uu+/yCbXlkSemZhU8ZBIbMWdPN0A7I
	vBxdc8qKwLUePiby972Amoe1Tl2h5EKjMMox/G448xyid1f6DvsDiTJO0FIZCWUPN0+xxha1eMt
	aBISDKncRnXhFAmQ25cju5z3OO4pdbFE3FQ==
X-Received: by 2002:a05:6a00:1808:b0:89c:1f2b:a73f with SMTP id d2e1a72fcca58-8c87bcbced8mr3885525b3a.17.1795201601384;
        Fri, 20 Nov 2026 11:06:41 -0800 (PST)
Received: from localhost ([153.61.198.255])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c87285c219sm1956161b3a.18.2026.11.20.11.06.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Nov 2026 11:06:41 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Fri, 20 Nov 2026 19:06:40 +0000
Message-Id: <DN09UU4NHKLV.29WR92GGDPBP5@gmail.com>
Subject: Re: [PATCH net-next 1/1] net: neighbour: skip the stale dst lookup
 for a redirected skb
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Jamal Hadi Salim" <jhs@mojatatu.com>, <netdev@vger.kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, "Eric Dumazet"
 <edumazet@kernel.org>, "Jakub Kicinski" <kuba@kernel.org>, "Paolo Abeni"
 <pabeni@redhat.com>, "Simon Horman" <horms@kernel.org>,
 <bpf@vger.kernel.org>, "Jiri Pirko" <jiri@resnulli.us>, "Victor Nogueira"
 <victor@mojatatu.com>
In-Reply-To: <CORE-J9UK.v1.r0.20261120103344-1@mojatatu.com>
References: <CORE-J9UK.v1.r0.20261120103344@mojatatu.com> <CORE-J9UK.v1.r0.20261120103344-1@mojatatu.com>
Content-Transfer-Encoding: 8bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Fri, Nov 20, 2026 at 07:42 AM Jamal Hadi Salim <jhs@mojatatu.com> wrote:
> Skip the lookup when skb->dev is already neigh->dev; the parking neighbour
> is the top-level one in that case and can reinject the packet itself. A
> dst that is a route via another device, which is the sch_teql shape, still
> takes the lookup.

It doesn't. The check never reads dst->dev:

	if (dst && skb->dev != neigh->dev &&

In the repro dst->dev is va, skb->dev and neigh->dev are vb.
The lookup is skipped. teql takes it, because skb->dev is the master.

That ends with 3/3 of your teql series:
https://lore.kernel.org/bpf/QDISC-6HS9.v6.r0.20261119070330@mojatatu.com/
Then 2/3 of it and the lookup itself can go. It can be a follow up.

Acked-by: Alexei Starovoitov <ast@kernel.org>
