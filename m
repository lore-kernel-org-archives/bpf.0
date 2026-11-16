Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794808639;
	b=2r99aXwKpwvIb6jo8D4LWRLrgIGK5OJBsXG/nnhYbzgLPsaYAdhUJfX8PR/BTBGsefyb
	 bKyP7Qd9vlpnKiPVQZOfZDEwrNUuleyaN2/Wh+2BaC1vV+v8+IjW5XwEky3EJyUj08+9O
	 jsO+MYpWqbWSKLeA8Tg8PYoKod1zy1ayFWYnQrxlzoZUyE4OdEYOQ2kVJg1FwWd6Aw+pI
	 CPf/RwwhWoeYG10SA3wHWKANrohdSW91W4p77h6E757x1qc1jJewmz+DaMZABXISj1iYc
	 RfzG8tlhZTNnkKbwRgb7OKTCLo3Evp2BFVhFtVqgS0y92TkRnW+Z6SEtc5xGSonqyBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794808639;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=0cX2BYToRj+vSyky57J2kfxPtA3MYdTKmzSXTDxkufc=;
	b=WjJWPy6jBWHsoAItp1Pn74cnq3VuhzylKWG6M1HnUTX54JsuCjEab2wYpAJ68e3auty3
	 YxFW/8v23P0Y2vKUqRwUTMSaA7MkIGWhMZjGNh+WLa2yw/MjT3xxxdHpadg4sLzU7c775
	 irQSpHd1i7QVfYYbL2lTViGD1GyFykW3RLEXMxx54aTpXj/R5twQ7n51M4X9z0WeG0IvJ
	 Z/v3798qY+79MI698ADOy58mgyIe0oewwmXtEUh2wsZMljWNxMyxk3DMdCfV9F1As3JiG
	 K4h3TqyvmcPWNXDsDviZJ0LGCOLbALH/ZkeZ7g2PjW8ESBPWoF7IKAX8fo2W+lZmsFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aUrfTFBX;
	arc=none smtp.remote-ip=209.85.210.179
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF826606A31C
	for <bpf@vger.kernel.org>; Mon, 16 Nov 2026 05:57:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CF826606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aUrfTFBX
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-8b2f59de176so3573614b3a.2
        for <bpf@vger.kernel.org>; Sun, 15 Nov 2026 21:57:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794808638; x=1795413438; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0cX2BYToRj+vSyky57J2kfxPtA3MYdTKmzSXTDxkufc=;
        b=aUrfTFBXtaBxnl/C9O5+0mDAlqZcPJxOiZItuPVpIQba3tXLD8do+m5wm+5oynJwWq
         RALof789TYU8bp7Tx51FJB2MjZ70Ipvx6LpP9/s+dPsJG78LlcNJTNnPTadXgUJWKPnu
         jWIlaAk5XUVfXrxJg+qNEC2C4Jx/nOOBNh8S7/sBe81tOP0uiqzWtrF4EP/fznWlfNQJ
         jOi5NXHACjRuhUACd06FH79d03M6OgqCnBcaVBuAwnQSZIkxnXpSsHyds2D/vpVgjToC
         nJ9xfktEFfoojSRUyfPHrV+IHC7npd+QRN424/CJ8UwdjSV+/C+DO9zENR5owi3naHoa
         FzLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794808638; x=1795413438;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0cX2BYToRj+vSyky57J2kfxPtA3MYdTKmzSXTDxkufc=;
        b=1ByYiCUO7xyaZODEDuX0p4ObuppKxjJl4kQfIMGckrA7NvPvpv1tHPxcqV87p4YXkb
         r5NHtk9N9P7PXhVwBLuVWBI1C4hN3mUadTEgi8z5D70BA3HIVps4/kOvnRwhXmTWmqRr
         aFilKwz7CJWpX1J2Apq9dDzcf1RZk8aEQp9tf/b6xN1l3eA0nXwSc3wW58Lx65pNUpgh
         hzVqk8aay12SPp8qz9XeI/cMHmiCQPKfzTI3hUFa7gHNCuQ0xIOgAi1p5xIgZPC1QToZ
         OidMcy3JVcF5yLDJo25vAQLxdu3aj+1yaeAVw73Jge0TrzMk75RRx/W9EpdNX2Dzhpb9
         JLRg==
X-Gm-Message-State: APuU4Z880ToEOXBKDCKsvqQw+rfMi8JTRybrewAg/svZcsMw57p686la
	sNU7nBuR3NIPJa5OHLvU8/IoTCagutuk1p8/Q3qn6uRf01b7Kfn3qHOpP0OcdA==
X-Gm-Gg: AYBFou0Kb7CilCHlIZkHm+nMCZnCVxcTmYeLyHhx6GtMaTNQR3IsdjJHP+Sus1U0rPD
	IuUbZ9kBW5mwAHnBZnbKtp1lSwEXEVXHrD5JEy2rhnKepAysE4sjWVKVfQv2zFGiiQf48Q5UZhR
	SQJS6laLZP1k0qOLBnqpMMZ403jxMFWQHkyezRgGL/MIJFZ9RhLEvOjczEUnrnGdcx3Hz/WVNud
	QLQTE0a8vW6/VFR/CzJ87SU0jHCu4KjkPr/0eqYd60x9mD2xx989iDH1YIscnPiSfr0HXwfHg/b
	4UosrETPgWE1Bxq+2eykMDvKHPiCNngwAZjTQZRzINaoF0KppoeiLmP+HkOIy+4joQOuXDTxTx5
	TFNVM4svMl40hM42+HgnUuu4BgB2lVbIj1aJlON9rfH+Qt4CLSM5bC4AbIkaoj0PcI/YfuLLvqe
	WZlttU08FMoyyqgekRLIHMvSpr19OY/mgyj3a1nDv/wYz3iYDx79KYuM3+tXnW/aN+qPRfh9GpQ
	VQSvHByuZEYdhGCyzTLQH3Xzt1mORCckhADLkfHZqGGlkxIyY8kcSx8MwBwMcVrZUn4CJHYYQu8
	ZYQ1sMW5iU5mB4p92VUS9rT2R47X2A9KLPkT1HhtZr3mARXYxy3KYHVNGW1oi4k5te4FYOejkNB
	WtfAYpD1Lo/9qm6cJKwBb1WjmtU0QFCt2yv1Zb2S/ds4thUI0iHxhdkUG3xWpCyjSVmS6t1UH/g
	==
X-Received: by 2002:a05:6a20:244e:b0:3eb:8ae3:e1a8 with SMTP id adf61e73a8af0-3f7a91e913amr9490399637.72.1794808637930;
        Sun, 15 Nov 2026 21:57:17 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.240])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8bececcc9basm3209938b3a.3.2026.11.15.21.57.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2026 21:57:17 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 06/21] bpf: Resolve BTF structs and arrays first
Date: Mon, 16 Nov 2026 05:56:23 +0000
Message-ID: <20261116055638.4171529-7-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261116055638.4171529-1-alexei.starovoitov@gmail.com>
References: <20261116055638.4171529-1-alexei.starovoitov@gmail.com>
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

btf_resolve() does not see this loop:

  ptr -> typedef -> array -+
            ^--------------+

The walk from the pointer stops at the array and marks the typedef as
resolved. Only the limits of the later walks end the loop. The walk for
special fields is going to lose its limit.

Resolve structs and arrays first. Then a type that holds itself is always
found. Such BTF does not load any more.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/btf.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 242b011ba93a..fffde271bbd7 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6015,6 +6015,22 @@ static int btf_check_all_types(struct btf_verifier_env *env)
 		return err;
 
 	env->phase++;
+	/*
+	 * Structs and arrays go first. A walk from a pointer stops at them and hides this loop:
+	 *   ptr -> typedef -> array -+
+	 *             ^--------------+
+	 */
+	for (i = btf->base_btf ? 0 : 1; i < btf->nr_types; i++) {
+		type_id = btf->start_id + i;
+		t = btf_type_by_id(btf, type_id);
+
+		if ((btf_type_is_struct(t) || btf_type_is_array(t)) &&
+		    !env_type_is_resolved(env, type_id)) {
+			err = btf_resolve(env, t, type_id);
+			if (err)
+				return err;
+		}
+	}
 	for (i = btf->base_btf ? 0 : 1; i < btf->nr_types; i++) {
 		type_id = btf->start_id + i;
 		t = btf_type_by_id(btf, type_id);
-- 
2.55.0

