Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2C93783C8
	for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 01:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792200535; cv=none; b=rAwxXnrHKnyXefCkgIxSuaUKtn9F7XB1DGsXbG8TtsqYDD2TtR2CDW8IF5mVrnWcA9JO3tRQxawc63mVEp8KVK/FiP1FPHY3msNdWMBbw5+A4mToxI6L8oPLA5JyXZxw+fzN9afQBZjW9IE6rXn5QB15JJIVPgAaNnfDYqsj2jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792200535; c=relaxed/simple;
	bh=nyPIuzYY4HX7cCgGgV60+lH4n+Qs1hMhO1xZzcbNp6o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=baI3FY0fAraaHRLd2yxWgZDachL+LQdb4AenGW5Mkz24++lbXDc0PyLO4n8mqwKHPtX3Lz3eLnnNwbDU1f6D+KiAgojSl0BwDbB1yBcR2xysqAQKWM9G1Pj6Lln/dQetCAAZN2+q9Ptv9ON+OzbanfuvR+MeJkx8vWiAPfXRzu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X4VCzRNE; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X4VCzRNE"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-398b3c37877so369314a91.0
        for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 18:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792200533; x=1792805333; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kD74tsJicQZulq5fwatX78W1q/HZeNsaDprLwtjhhBo=;
        b=X4VCzRNE9M7D+8TJOV6Ehxcb3uCNuMXfAl+PtC899BislIcOKrTFw6CWta9PC+3TM0
         5aJrUHXJp6g15a0c7MFAueLCiShpwUKrX7nFnEPeYaSzVQkVTuf/nfK0p+4ED+xEz6wb
         89rxcGVRRye0vOcjdbvSu7NoyhJYngCIHbgBAVS5CQLWd8WJH2wgMlLI8Pzkj/43jkzo
         fp0h0HXXDoa91D8ZC81c/4Kmf/R22k9RDzAyPgtNaKlZhG2rU/B2cGSAmfeoHO2HKTfs
         1MvjjhCTDWuuGn3J2P1MYxzftlu4nakLk3+8Zg4HsjtAXfTw7wiZA9jpCx5cEv583fwa
         D5AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792200533; x=1792805333;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kD74tsJicQZulq5fwatX78W1q/HZeNsaDprLwtjhhBo=;
        b=b3wM4uFNEbYRaNDZ5O5vY8aZo3RY7zJo+mUsBKXHvYL1g8To8mFbnSqbWH2bOoeH+R
         IeqUdfZLSySoAOemH6ml14+/fgK5MEK+l4sGphzSSTDcs+7RezZ5wSuMcOfsfESCBqZ5
         ox6V7Mn5guZpD5GBlz54n9DqA9FyMRk8AldfQHNM6yARB7/CnpVy1FhH7Y7lzBXD6qJQ
         /Du2DbkJDDp9jdsIi+Q1x9f4XxRrBAwDV4ga5nZa6w5jom7/EUdEJFZce/6Ic1z+m8gS
         +aQcEU6fudFr3/JDjoIKpowU8u1FyCL68zqE8u0uRm4dSNErS57QulQi8/CPF6Qs1NQ6
         2ufA==
X-Gm-Message-State: AFq9FYK+my7IFopqzSaGkC1nQepnm+zV7JwIHI1DqvqUNkdS3CX5novy
	9sf8rsoCXpimzgutUVB9necJIg9uZdqmZNpobOY8QR6V3iNXBjZHmtiC3DJtS2h/
X-Gm-Gg: AYBFou0CMxe4fgRsjSSxgXJcbyIQpTUn3OkFFAev1b1wlaBHIQboS5gsqfYroOH1zUC
	1XweOzungdZIs/XvhLbk9QGPHbJ/1wtqgcJBW14qtXTkPNcwCSl7MFDtJNMadz4hyJf6zWycXqv
	Bkk2ykhI4xs4IaABxSpq2BVV3ecD/efUG2ffuhk5aXfUA2xxAsmDF8qfWeagMg8pSlXAHJcrE51
	/9rFxIFnujps8au8Rd8DskOSzN508Dr5L/Sk2yvadlsor3rd59K3lpNpsIQN09BLjMFVxep5Czz
	X2ip+C+JN8P05HX3cxvFq7J3TnK2G0ZsR2OdEFazLE5tWR6mbh7BUuIFojhQVu5wsYvdHAlk+R7
	vtS1nSjHG9ZWbCCvIeS6O1ZMcJydad4jWv6ntPLcJ0rOBR0/TSDbYcL1I0x9G+nG2/m7XRnCyRG
	xjC3k1qy98xCFbpIWpz+6fnxE1wO/uVqftrlgUH2aSeNibZViq2BAvH4+oDyOnR9lp86prGULmF
	kSWB4Tgs22Q5a8MWVo6mUobDV4AurcaQuHHqiOlWnLRQ0Eckhr2S+C9mC8RdiH43VrfIVFCK4d1
	7Cm8Or3hsZaKZpEYKJQ9vYf7QXTh2g38lp3Wax7z1Ip+3DpnD9O32A==
X-Received: by 2002:a17:90b:28cb:b0:3ac:aa8d:19e0 with SMTP id 98e67ed59e1d1-3acee28021bmr1271220a91.9.1792200533028;
        Fri, 16 Oct 2026 18:28:53 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.241])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3acc43a1981sm6233805a91.2.2026.10.16.18.28.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 18:28:52 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	netdev@vger.kernel.org,
	josef@toxicpanda.com,
	mason@kernel.org
Subject: [PATCH bpf-next 20/38] bpf: Don't bind a program to a netdev that goes away
Date: Sat, 17 Oct 2026 01:24:33 +0000
Message-ID: <20261017012451.364800-12-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261017012058.355787-1-alexei.starovoitov@gmail.com>
References: <20261017012058.355787-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Josef Bacik <josef@toxicpanda.com>

bpf_prog_dev_bound_init() looks the device up, takes bpf_devs_lock and
registers the device for the program.  The reference it holds does not
keep the device registered.  If bpf_dev_bound_netdev_unregister() has run
by the time the lock is taken, nobody takes the program off the device any
more: the bpf_offload_netdev and offload->netdev point to a net_device
that is freed as soon as the reference is dropped.
bpf_dev_bound_resolve_kfunc() dereferences it while the program is
verified, and a new device at the same address finds the old entry.

unregister_netdevice_many_notify() leaves NETREG_REGISTERED before it
calls bpf_dev_bound_netdev_unregister(), which takes bpf_devs_lock.  Look
at reg_state under that lock, and treat a device that goes like one that
is not there.

Fixes: 2b3486bc2d23 ("bpf: Introduce device-bound XDP programs")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/offload.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/offload.c b/kernel/bpf/offload.c
index d855399812ee..c615ed46f629 100644
--- a/kernel/bpf/offload.c
+++ b/kernel/bpf/offload.c
@@ -250,7 +250,14 @@ int bpf_prog_dev_bound_init(struct bpf_prog *prog, union bpf_attr *attr)
 	prog->aux->offload_requested = !(attr->prog_flags & BPF_F_XDP_DEV_BOUND_ONLY);
 
 	down_write(&bpf_devs_lock);
-	err = __bpf_prog_dev_bound_init(prog, netdev);
+	/*
+	 * Behind bpf_dev_bound_netdev_unregister() nobody would take the
+	 * program off the device, which goes once the reference is dropped.
+	 */
+	if (READ_ONCE(netdev->reg_state) == NETREG_REGISTERED)
+		err = __bpf_prog_dev_bound_init(prog, netdev);
+	else
+		err = -EINVAL;
 	up_write(&bpf_devs_lock);
 
 out:
-- 
2.55.0

