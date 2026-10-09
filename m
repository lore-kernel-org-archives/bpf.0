Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819281E7C2E
	for <bpf@vger.kernel.org>; Fri,  9 Oct 2026 08:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791534746; cv=none; b=DXZKSLkNPdwM0aj1j6m9mKQoXvF7Z0Eg2F+yW3U9MUjJjzekEYFRw1Jw1dlDV9u38LI3TLy/W9Ktnr6eKwR+M33R6BsUETOPlYOQsChVyxtJtMFz3IBJdInyOi1LZQQt1nqK1mjKtr55BiG2G4gKa4s/AlQMjNtFl+ujlADJAIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791534746; c=relaxed/simple;
	bh=HQTQr8Qalo+rFlyXl8bRnberljei0b6NvxIiVVuSolc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jsoLm12eBFzZuAvqxKOyJsjbP2KwQlQhM/qH6N+Zc0tx9WidCNYvOh1R/D0AGKEuzjWpTu8GSnMhEdznZNo65xeg3OwPNS4vxzS5OhGUNO2cIbzfp7gQbW9rflBG5AXZvQosPxGHLy3yzO8IP5EIDgGVNicJAq3aVxL7MNsih/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G3ZJQzMb; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G3ZJQzMb"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-354ba08cfd1so191230eec.1
        for <bpf@vger.kernel.org>; Fri, 09 Oct 2026 01:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791534744; x=1792139544; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Os5itKtURnoDOk10ONflhIv3aXoVE9vYLujzF6KHJ9g=;
        b=G3ZJQzMbKJyHh3BMNaye9M0F5yHCbt1QSMaraF/zL9fGEHBbmoFKLzPd+NwLWxLRNq
         rA9zbECEk++Ehg+IFqvwU6xrIzcyYrEOQFtps/Bsnic7r8QGgYekW9rMzD1wLFmohSoH
         3G/2zd5MLOpvII5qy3+W+60dOe4Epx16q8o7FCok3Ng0sehDWYRM1e/ExQ4CQZ8qvFzc
         hQP/3GZQn8Soac7Ysf+WNbn/EL99JrpYGYpRRhQMBMsAFn5NjzNTXe3ZxrYyhDWEIUvG
         UrBcicte65It6U+Z53hewqvKltuOomfxcdeufwKBLOyZ1OR9M4wl6fB+WOWFV0roXypK
         uhsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791534744; x=1792139544;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Os5itKtURnoDOk10ONflhIv3aXoVE9vYLujzF6KHJ9g=;
        b=R+OwhxhdO+xTo/LaMxHv33n9d1tjNbPQ3iw4HExBDiyMjGbYVNm+zIDMehL9CmJQt+
         3PwvsywRnsajPt3En+V73q15dcbrGAc7H2rvpOFCPHAxuHFVRVv9Ejnc2AKxBva/lLaQ
         Kp88+18Dbt5czqxV+rwf2rDUk6vdW9RQQ4f0Ck3ByqgihE2z6+AIgSu7R/Z3dX/4kpyu
         PZinpC1McDtnKQCGgpcA5ttemS2y/PQUTVci7ASFfbWHgvcqkfzRX6qhH5eT3ggmoyX1
         Z1iravQyoWjRrtUrBIPaSR3cTxiDBMeQIIJnESo3MvHRTNkt3CANGa11d4ouKezUuLgo
         SvVw==
X-Gm-Message-State: AFq9FYIW/xDEalnmy5Al2/A/4NgLgAV1APZHtGDXWoPKdeoE/WJXi1v4
	KKYIGMNu/vPqBtmcrCEc52P7PR8MaaP2Rzu5rsWBYTH8I27jKxKAHvK+1VXqhz43
X-Gm-Gg: AYBFou0c81mLJPKtsLGy2z2PbLtazjCoYobcwicKX+IqMHulUtlZWo0KRzkAjKU7RKM
	JRKzebMC/AFN5URyyApmZUSZnxMaqA+OjuqrZZQSJSkli/WZOq8w5vJuH+m/XMx5e+yxlWYaSWM
	Tlhi61gt19LVc08Lgal7fiJOWNJFyT5xizMyZdkZQJofsX1WCLwbo47Riu/ViEKuwv5QPMZKuxY
	TVfH83kx8n5pcHnAJfNJIntkyjRVe2MMr4qgnLnvr7NbwMW1yyNBh1+G8ramAyITc1AO3DtMj+k
	bNyXLoyEzyZwlgSnFAAwUKkq6Trc875Q7DQRCwexGD5S59e1MV5Hj+8i+lyYhKGB3yaLjaLbckt
	wqe7SnuqLkXKVs40MwMFDvznmHpm2xzKlc5NdywDuucQKNT2ba9lGME6XzypFqbkljYeTdc1LFQ
	+NWaOexKUGAqMZteb3W2V5qJlVpBkH+LItrBIjoSuOZRZj9mIKcxyZsuQfDnyY8wXKZKroYULZh
	AKJR0csZxNbJnRa9WBin/QJz2LBC1O1
X-Received: by 2002:a05:7300:fd0a:b0:351:25b6:c867 with SMTP id 5a478bee46e88-3537dedd5d3mr2802602eec.2.1791534744192;
        Fri, 09 Oct 2026 01:32:24 -0700 (PDT)
Received: from DESKTOP-31QBR7C ([103.120.166.86])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537ca79536sm5388480eec.16.2026.10.09.01.32.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 01:32:23 -0700 (PDT)
From: Rahad Bhuiya <rahadbhuiya2021@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	martin.lau@linux.dev,
	Rahad Bhuiya <rahadbhuiya2021@gmail.com>
Subject: Re: [PATCH bpf-next v4] bpf: fix symmetric register-form NULL-pointer check in check_cond_jmp_op()
Date: Fri,  9 Oct 2026 14:32:12 +0600
Message-ID: <20261009083212.900-1-rahadbhuiya2021@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.3
In-Reply-To: <20261009043819.1208-1-rahadbhuiya2021@gmail.com>
References: <20261009043819.1208-1-rahadbhuiya2021@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Thanks for the review.

Regarding where the symmetric form arises in practice:

While standard Clang compiling high-level C source typically canonicalizes
comparisons against immediate zero into BPF_K ('if rX =3D=3D 0'), the regis=
ter-form
BPF_X comparison with zero in dst occurs in:

1. JIT compilers, bytecode generators, and BPF linkers/assemblers (e.g. cus=
tom
   assemblers, LLVM register-pressure spilling/copying, or runtimes like
   Aya/ebpf-go where registers are mapped dynamically).
2. Alternative compiler backends such as GCC BPF, where instruction selecti=
on
   does not guarantee commutative canonicalization for register-register
   conditional jumps.
3. Verifier consistency and completeness: commit 6aed0134d3cd explicitly
   hardened the verifier for register-register NULL checks ('if rNullable =
=3D=3D rZero'),
   but handled only the forward operand order, leaving an asymmetrical gap
   where valid programs were rejected solely based on operand ordering.

The points regarding dropping the stale source line reference and clarifying
the register-register example ('if r0 =3D=3D r1') in the commit message are=
 well taken.
Happy to refresh the commit message in a v5 if maintainers prefer, or keep =
it
as-is if no further code changes are requested.=0D
