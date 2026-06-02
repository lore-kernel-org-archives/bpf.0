Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2D73FBB55
	for <bpf@vger.kernel.org>; Tue,  2 Jun 2026 17:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780422728; cv=none; b=HTd0SGAEQ2qNgAIvJN9djVnaPBsrSGupH8i6wd63QzqCES/NDNn5UsYnIEzhZ/VNF9+tbvSb7x6kGbaJfjDRQotJjzyNES+avq8UrZZF4bEEAEFnPDyMBu0imljjr70RXd+2dO2d3HteSdaq0TlcendvENTOExW+aasSFnDDJck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780422728; c=relaxed/simple;
	bh=6UxLPoosSjjK0FHZRJwwD8HQ+9fJ2wKBoHOJ2mgOd+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NfymZa70I2NbjnANFoOdpeMU2CPHoYPoNCFkSZQCXX7ATSBNwmYlAY4P7v0IZU2DjDN7ZnzFOYM5g6VC7OfIpUEkARDa2+lSQdLLAaz40o9aVI05IuonZT+WCpGbQlCFtSkWxNbnycwgM3WZmxm6YCUfcd8xBDK3Nxd1Qq1RNIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XIJoULXf; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XIJoULXf"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-8422f395a4aso1951589b3a.0
        for <bpf@vger.kernel.org>; Tue, 02 Jun 2026 10:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780422727; x=1781027527; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ylImfVggkiWj0J+iskvbahdquQCR6qXaQDQ1DoXHEas=;
        b=XIJoULXfVnDAAn+kjmNMLdJOKCW0VXRh8nbXOqPcBWvsQZ09xhJ6liCofy0ZW4iFJI
         cM6EOVUFJk+18eULkPpkb2sNdSbGJ9ns2L2SlJ7xzPras1jwNLd4FvTWd0T1Ox7+QMBG
         0UY5gNkdIDqLgRfJq/HuW83XIjZrzjLsc7CJD6exFC7GiVyknhUnLLRoboV1Z60Xgq3Q
         i88kifYBul5UI5+ONMSr1iQkcF5zIKgc3t/ptpr73dAJ/+iBdDiIxhDcC1J4ondMDfm8
         GKL3BuZETSwrhoqdgP2OZtAZcbLV0jxWzGY+ZXXSUNHcoJ/7HbufNS+4Cn6jRTltEgW4
         Lrqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780422727; x=1781027527;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ylImfVggkiWj0J+iskvbahdquQCR6qXaQDQ1DoXHEas=;
        b=NJfmkw4GslRLHlRGUUoBJAwvyGKlVgLV8NPBoB/m7zgz+XcfIgnlodfu+QE7Rp+3ej
         Q20kaySjk+nm4ep5GEaz0Pj1kTos5qbVaVTE6B/GoUGiFXndgka/zPL/dNqB28biDYGj
         pHZv2Pf3cdfWBwc0tHwrYbIzazErA1QqlkNoYaFthcSooNHVSDpSnK739G5C89yZeZim
         9y+Or0WtT6EN2OC6H6p87VdvOxUT32gKyZAXfi2vvlPj0RrAjqSE5sJ1fYWNUS5vA5dN
         Sh6sJb46j0GfhT44ZMw3DDBpqh8LiJawgYWHuv2kCEE+26yQO0btDWd8BtnGC+VdHhZs
         pQcA==
X-Gm-Message-State: AOJu0Yw1qHtsZzZtK/Y2mMPr6ZoYJsQcFnoKzEQJbi794LE/GPt4+i+r
	6KFRqEJN2BnFtCv4yeu433zhtU5rBJCCpAWEaXTEryLh39ylS9ai2+gMdpoU2A==
X-Gm-Gg: Acq92OEVCO2QTo4Yerm+26JkPjD4/C8LvE32s80m690cZNkrJUdAN6tjhCa9L/JnNCm
	9NHg86un9qpjnojSzacRxGnyH0sm+Jxb4ibhT0EJ2Wu/O4IcvH7OVPt+7JJN5xXINyw+4GIxzPm
	ekBoIvPFD/GC7ZbZtWvWB3CFlO+SNERVd7OcFGFkYgVY2NFLJ36bCfSyjRecr0vtgcfWfs54rIL
	6SCFvbNYM/Cd9ao0zuxzVGuY58SkSl14ZPi26IdW1z71WKULAHo/nm82KAkiF9h3Ui7Q8PlGatq
	ExIadgMEdnarnVZwscCS1HfhnS2f3GvsX5KK26eiviTB+KOqtmeV6apSDjcmyGVcjbLXXdVwEy3
	DBV61of70jp63cCEiSoYSJ6cTIzwRNVMxsHIssXWQ2ma66fbRZNv6m5Fu/adPsvQY3uhg+RnB8o
	Z9N5U08zQ70uOiEP8K4MKAhVg=
X-Received: by 2002:a05:6a00:420a:b0:842:4f2d:c4e6 with SMTP id d2e1a72fcca58-84283d5b776mr259847b3a.9.1780422726588;
        Tue, 02 Jun 2026 10:52:06 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:7::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-842828e02f9sm426339b3a.48.2026.06.02.10.52.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 10:52:06 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@kernel.org,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next 1/1] bpf: Silence unused-but-set-variable warning in bpf_for_each_reg_in_vstate_mask
Date: Tue,  2 Jun 2026 10:52:04 -0700
Message-ID: <20260602175204.624401-1-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The macro requires callers to pass a stack variable, but not all
callbacks use it. Add (void)__stack to suppress the clang W=1 warning.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 include/linux/bpf_verifier.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 3dd2d21230af..c248ff41f42a 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -582,6 +582,7 @@ bpf_get_spilled_stack_arg(int slot, struct bpf_func_state *frame)
 				(void)(__expr);                          \
 			}						 \
 		}                                                        \
+		(void)__stack;                                           \
 	})
 
 /* Invoke __expr over regsiters in __vst, setting __state and __reg */
-- 
2.53.0-Meta

