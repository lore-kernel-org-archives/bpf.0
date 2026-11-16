Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794818497;
	b=EpJx/BQ2x+RdUSWGxctW6aNAd6n0FcwHApWMVKE8mzhgMtBdiH31aCgh8llrZFO6OjW6
	 cEJjGbkDqz7X2kdpu3J2DAF3V4nnLLMRJkaCbFM9kSuBqLqdoicoPzVRSCsGk5udoZYZY
	 ctcB9J7KLlhibTiqvvpGYvhFu6E13Gva/DCblVvb5R2pRVd/Js36vBafTU8ltIGA25oMr
	 s/pk92kQaS3hejYjAty3kQlGIjDhOZLEla/rVvSRcyUcjXtK9fnHH3GynSsKSv6gyFGuZ
	 eK5xTGCagoLM1riTmv72Qp9uDW09MlhDEg1MVx+rFITEIj1EaXUG1kEb1QbLdXSta2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794818497;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=P3nMcjWv+xj29nx8pWfGlhho4ATOaCrbxLj/pbD7y/Y=;
	b=J9fGqED9KYZio7HF8n0OTAUHJQa+ycYoZJhs4X9AebOkrOO2Hu58ThgvQPPjYEMHyi4j
	 TwSJUb6fhSUl+SL35GRkEewnyuLyvz6yTSth3d4kcrkschc+VXWsZsg0Bi3Jh6h4eFrRJ
	 0HygjE2yE1kQhg2FHVOD2T9gMlJBLVUZsJ030wXNiUznm/v8V7lwWk8XP0QswRFXqhVPi
	 QTHeYGCHJrPS2NYpeurXEN9LlMaC/GMywo8csI6gF7+Yn/M7ExErSxrVksair5ouF0DZy
	 q/Ogg5ThI0UR/4EIw7Yuo82vzfQ6C6unHXsBL0hpurfmCa2T1qxnqWsq3rDp9alHNHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZP00IxpJ;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B26606A31C
	for <bpf@vger.kernel.org>; Mon, 16 Nov 2026 08:41:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C1B26606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZP00IxpJ
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4bb7679f28bso50875e9.2
        for <bpf@vger.kernel.org>; Mon, 16 Nov 2026 00:41:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794818495; x=1795423295; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=P3nMcjWv+xj29nx8pWfGlhho4ATOaCrbxLj/pbD7y/Y=;
        b=ZP00IxpJab14kKuRe88DihMZ3sUGLLnAMoZbx6Kfw/eLGuEOaKx/tjV0jOXIOl3pQZ
         Uj7XXlwgBYHGEFZDvny58xVO230lxGiGvctM28rK3d+IBntRZxpQPLZUOUgw63x2iwKs
         jHaUfpoqubX4l80Db0RtAhYQ/O53yLrYu7P0rhfryHreBVsprNjewnuwhGfIzZTleO5w
         HSTtY+8UBL1aWSM+9/b3UwVyTx+hsoHZ4+DKhotoGZISxO8PgLuqLeUIY4M7Jo+1zMc9
         iYmYe4Sn442PJKjCzAbuRm9fSjl4FszpAWcaaeGvBntjfXbCVaYuRS/VmwAwGmsiAMmG
         Zrjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794818495; x=1795423295;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=P3nMcjWv+xj29nx8pWfGlhho4ATOaCrbxLj/pbD7y/Y=;
        b=XD3hrxwAHDLbAZ/NCXavhnm9/FqPUtwn1xp9Wqh9OaqL1KE4G9MNvWCo6oTq+oTHYX
         4sO5EvO+hJZ0EFB3j/s7cOayZ10LN8jeiVvlSsIPa+/ZmsaLB5SAbklV6XqAtgNwrTE4
         8hwsnlXCWpRMYANqApZ3V5Iif2x//8/ffpM3G8qWNsxsEp4E6cKOLvf3EzvqEjfh1A5F
         gQyvlLg0S5OrdoVkaKnXsl7WeMqP3gqtWlM7UKItdGzqERRH5IoIk3e6xPnBtQpKjhCu
         WZDah8MdlpCieo7LTnC2jQ4M1jgQ2N9AZRldDtcLtVsNZUhS3eqTf94jMXiJucsIcLPc
         VcSA==
X-Forwarded-Encrypted: i=1; AL+hErEoDKhbo26wTPD3TCQFEtKoU1HO8YKmIvYQ70M8n+SDmci6x/c3aHDMGGhTVCLVwkpFjuQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z96xBxKi3ctfhs+DE1gXfxVvJvc/Q+cdd5ARaIlYLu3uXuKe0dq
	5ScVgRodYp+u38AQR4y1VdZrQ9oZYTYGULSonKnb1lMuPUB124NAeV2s
X-Gm-Gg: AYBFou3RjN54/XF6yJTkTRGuLItFQjYpM5JVvCtBf6l8k4QqH7rAdMfTmL5uzp4euM/
	MAMoUal7bXkMWD7v0VBkesh8laNtR9IbmGpYZzut5cXQWENSRJ/V+3eTyzCJ4vpx395Tm8/sNEa
	NRTLfXaqHIvHrDIbSgB7cE5nke1sDQHEFl2kh8U5WtDTKMxDO+7fPXWxgK2weJ+FkTbE+4zk4A/
	Pgix4GAPRIOAzW0LMBJPn7Z0fTAerBKMYUYb7I/AiSsHgJqvBGChXylpBNGM/69jKM31kjmFrOI
	7sk5VXOd5GZPCb5uIB8qewOwQ18TcIACmz+3nvzFdSEtVrv0RFuv59VEI1RgmU4rNWQ4aPB4J0E
	OPc2GVTGXHLcQfKPLwYtB9GGhqtZi5t8qNXwt2maQw/nEbd11kFGGYn5f5bsGeZyYSWzPves0On
	d6aS9ETGHybtOl8uwdfiw0lVrYNlMnXeeneFL4nvLCzEM3eUBvM7mOHP2bH7SeERhEhgUuwg3KG
	GyrXStK5s+Cy97n5GUrr4CwKEd0dTiNxVBB6wubfIYJfvLu8pbrN7d3hGgDUYmHy0y3Nf95eK2f
	grI+RSXDVR5laRHvbAOcBKUguMyQcMW3D7RvwILp4Jyc7wS0KirDb1gxPFWgwd3mH0HsrGFR
X-Received: by 2002:a05:600c:8a17:20b0:4b6:2242:d0be with SMTP id 5b1f17b1804b1-4bb5599b367mr158884065e9.0.1794818494950;
        Mon, 16 Nov 2026 00:41:34 -0800 (PST)
Received: from Nuel20.localdomain ([105.112.221.201])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb62d5ec30sm284300555e9.15.2026.11.16.00.41.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 00:41:33 -0800 (PST)
From: Omokefe Emmanuel Onanaroghene <emmaonana18@gmail.com>
To: Tianyi Gao <tianyi@cloudflare.com>,
	Hangbin Liu <hangbin.liu@linux.dev>
Cc: netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	kuba@kernel.org,
	davem@davemloft.net,
	edumazet@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	shuah@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	skhan@linuxfoundation.org,
	Omokefe Emmanuel Onanaroghene <emmaonana18@gmail.com>
Subject: [PATCH net v3 0/2] selftests: net: veth: propagate check failures to exit status
Date: Mon, 16 Nov 2026 09:41:05 +0100
Message-ID: <20261116084107.6675-1-emmaonana18@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAG4wq-cd01i7YrcFPmma=BXUcwn_PK=wneKW=vyEBYzQ3Bn7QA@mail.gmail.com>
References: <CAG4wq-cd01i7YrcFPmma=BXUcwn_PK=wneKW=vyEBYzQ3Bn7QA@mail.gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Four checks in tools/testing/selftests/net/veth.sh report failure
without setting ret, so the script exits 0 even when they fail. Fix
all four: chk_channels() plus the three "bad setting" negative tests
spotted by Tianyi during review of v2.

Changes v2 -> v3:
- Add Tianyi Gao's Tested-by to patch 1 (thanks!).
- Add patch 2 fixing the remaining three checks.

Changes v1 -> v2:
- Correct Fixes tag to 1ec2230fc721.

Omokefe Emmanuel Onanaroghene (2):
  selftests: net: veth: propagate channel-check failures to exit status
  selftests: net: veth: propagate bad-settings check failures to exit
    status

 tools/testing/selftests/net/veth.sh | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

-- 
2.43.0

