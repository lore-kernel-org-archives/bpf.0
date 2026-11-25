Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795577584;
	b=xWekMLXKlem+SoLe8BM9ut11/5Ro+4tbKgbO5pe5s/CS3CvM/O4K8sX0Y96LJ6r4/mFq
	 CC03EjxuKOF+2x7G5hN/chAm8V+dWJDt8PzjgZx3FcWPGam1hNTe1rGUEA28+TSqM8bZY
	 N06LXVfGBqBtH/UfOsMnlSKbWW91aPtt/uyv6xtdw+rkO+HmkInQjerkBD2O/CzuyJbjk
	 i9WbXDnaBxMJ2ztoWWJCsc80d05+K9mivSanU4TBRVXrGmLs4ivzLxFUahjMyQyBt/j/N
	 ljMiuCPAAEaAOq6C4RUDKQlMljkOzqOoLNwonEUQEmjPaeKW8BHM0soSCWfEEbtKRIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795577584;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=8Hw1Re73JxyniUZgjNRzvpEomKIMU1jEfJYB11AqM3I=;
	b=qd7GrQy6MXlI+A5V8Ay0hTknwrhLnkqNMnAfViKXRROJ7L9CFs3z39bbV5kY2Jztp5D2
	 ZvkOvwwx5irgWAC6WHq8nNehZ/tWYtvHaxoiiPfsigjM3SlNg6hz1O/NhsLVxEp12qxAD
	 oYGdI0Vad8854RZY1Hj0uhbSWmzqKndL88CFJ0LAFEoBaknRk0jdoRzUxvlsE4vOk74bD
	 dzBKq9Pjn01elmQWJhdf/rSvSr0lKmV9OzNcr5F4UZE3vTAnBTn4a2XsUOkxJbt3UAOKN
	 wvrSkIxoMZT68unVXtTjKljn4iqqFJHsYPShdVbBuUFZ45MftRA1yEkqyjTZ9gxOi+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pRpScTAW;
	arc=none smtp.remote-ip=209.85.214.170
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA3D606A32E
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 03:32:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EDA3D606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pRpScTAW
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2efe591a1f6so17775715ad.2
        for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 19:32:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795577576; x=1796182376; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8Hw1Re73JxyniUZgjNRzvpEomKIMU1jEfJYB11AqM3I=;
        b=pRpScTAW7g7oUfuSb7O+2S7eR6Bl4yA4Z4mY1JUGqmo94wu6OtKCx/v9X9VJ8DrBEE
         ZxoIRL3/5iPVFM3cWn6cakKndwzRgyF9eJvpe5hpf+evaFf4br+mPVjEm2ku7DhSgH49
         Qxx+wb1/kqOF+aqaM+P6c9z27xMVDpo+7PC/ZULWM4PtFPa35ZBeDmk3VwKQjPUnGBqY
         0EVE1Pnw4QiK6say7IIi5qgdcXYyn6XzP1XjIuutiEwO2XGkmKFO5YE6tmzUOcJuxCrn
         Usu1o3yPze84ZiJ1/VB+FEcsPsIOkyy3jzZDVTefWtyprbCfB/lPdYZeG9QUxzU81dMc
         EqAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795577576; x=1796182376;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8Hw1Re73JxyniUZgjNRzvpEomKIMU1jEfJYB11AqM3I=;
        b=ww8lE+hsx2kd9BcfrIzOYaQJPktVUczI8oC2xrWyoxKS5UwDiUMTp/agAXVQL2QaH0
         epKKXOQnGRR8neqS053KS2gv3OgSsmdtq09IxldeaxYqwsxTnk76nHuHegEMnP7sCgvY
         9tcepbTnZP4nndCOhpOIBPcJ+WpbzewIoduNdasVNU6pAdF2G/QRBnTLEY+WrDu0at4j
         WITfQGiJN2JfGJXbhaJOsWsC6Q27O2m5FYcWiXgRAX3iblG93Sf8hm+puTsc6ygypwUl
         Fr8wMu98qrSq28F2GtJM1xZmczwZvyVVmkqTk7ePH3X957jgixWOgdvnsR+BfOz6/0Z8
         ln2Q==
X-Gm-Message-State: APuU4Z8fC8T65jDCBiJVwCbJzDkgBAwhebpEoIU5N5XvHF4DylA2/HO9
	3EfXQ2lq6QGZOy8kxd0bUf95+syhfG3WIdIei8J1jrAuCc8cEBROy06196mmIOEe
X-Gm-Gg: AZFdTZejT+yN8nridyKxJAYuJ0lI3sNziVbDvvs9OOA2u0QYKOHn0KOkMz5id6FABxs
	Tt0Kl4U65J2UpdQ9jYnC0daUGWi1LR4R1hmdI+bTI22QiIag4RziiDRlhAEDfcoBrN0Fv10RepC
	6sDThunYljJh65WDd52Dp5/Gjjo04cVuwwK3C7+ink3donSZCSflkG7D8nWNpv0j4xkIX21Pee1
	M+dBUHnr8D84B3oZ38mRMAocSYFXzHNcMxQ/WvzSznGI3UU5mbRcW++I/QrsyCUqMIw9VM4r4jv
	6muA7IW1UgnLI/7C30RU0pakONJgAbeJ/278xwTNwhhqXROKY96JUHQpPEkMDQrAqowoPlzI72n
	M7txFJL0ympHurnZGYyiYYIXBNA45+27VE6eHuQewZOyt5c040EMUtgBpnGvT6AAe9KT3A9ujOk
	JSl9VVKIp5/xkxPK5JyrjhkKa17hLmQ8SjPNPyj9i8vV432kk/42nZ6a/3DIwkRHn4Qe0udfv4y
	zRgJwT9UsHuqNb0hu4Ypc1pCjGYIn2I40mqRT9SttC0qB67PBv916ft9Ty69keFFPqGSbSqgfTb
	/kxtwOzUsRMZmhHP+2Ac74f82lD0KlQ6NLMDoXMM0M8jPR8JB6OT0jHURXWEFpQyh5+tRI9Nv6Q
	8rBOVRwR/LGOuy7XkkfXBQ+EcUyirpTodmrguXDCA44Oto8uUWZAbPPsoPrmEtxp0rDYjM4kT0s
	Y=
X-Received: by 2002:a17:903:b4f:b0:2f0:22fe:65e5 with SMTP id d9443c01a7336-2f03f1d0f8amr147269295ad.60.1795577575970;
        Tue, 24 Nov 2026 19:32:55 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.245])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03f120016sm77866285ad.58.2026.11.24.19.32.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 19:32:55 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf 33/47] bpf: Require CAP_PERFMON for the dump of all storages of sockets
Date: Wed, 25 Nov 2026 03:29:24 +0000
Message-ID: <20261125032938.670542-34-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261125032938.670542-1-alexei.starovoitov@gmail.com>
References: <20261125032938.670542-1-alexei.starovoitov@gmail.com>
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

From: Alexei Starovoitov <ast@kernel.org>

inet_diag dumps values of all sk_storage maps when the request names no
map. It takes CAP_BPF and no fd. These are data of other programs, and
tracing programs keep addresses and memory of the kernel there.

Ask for CAP_PERFMON. "ss --bpf-maps" needs it then. A request with fds of
maps works as before.

Fixes: 2c78ee898d8f ("bpf: Implement CAP_BPF")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 net/core/bpf_sk_storage.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
index 1c59300af05c..67288177492a 100644
--- a/net/core/bpf_sk_storage.c
+++ b/net/core/bpf_sk_storage.c
@@ -502,6 +502,10 @@ bpf_sk_storage_diag_alloc(const struct nlattr *nla_stgs)
 		nr_maps++;
 	}
 
+	/* It's a dump of all maps, see bpf_sk_storage_diag_put() */
+	if (!nr_maps && !perfmon_capable())
+		return ERR_PTR(-EPERM);
+
 	diag = kzalloc_flex(*diag, maps, nr_maps);
 	if (!diag)
 		return ERR_PTR(-ENOMEM);
-- 
2.55.0

