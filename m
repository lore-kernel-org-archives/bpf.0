Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 353CE3F54BF
	for <bpf@vger.kernel.org>; Mon, 20 Jul 2026 11:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784546006; cv=none; b=FKmzF4drZKIe07d3+seBV1Mod0MhSYSKOvavry/2mPkzv6tpciTz97stqjGJ2x4tDEvNDN5NUbqNQAo6eUxcpOsXGXpbEIDTVNG3dwndvAUtucDauF0GIxwTD5MxrGAbtl3/W+exrcONP8Av6o7Ot+/pBFNlfP30f+tKRT3KXJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784546006; c=relaxed/simple;
	bh=XLOtvvCv66YQSGuoLu3eRvzMzjzimYKdjqYj+ocM9dc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MlabXvVBtsF0ePYF3x16dnURtZ4l+HgVUZ6ma1hmv14Bt+0GgF2XroioQLcsrJsFZfRSHI3F/24hc/aaFNN4Skvbe2bC9YX2a0b0AHzn8my02OvzwlggUC6nN5NWWoY4p4Z4rNsWzYqxMSCMfuviuG6V5zNgrSEAi2JivSHFu50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Ge6OkG3T; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Ge6OkG3T"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-49553515a8bso18873585e9.1
        for <bpf@vger.kernel.org>; Mon, 20 Jul 2026 04:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1784546003; x=1785150803; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QN6Sa3FnT7k2MKcUIt4Usx9BRVJXnBuQBTO+EcPn68M=;
        b=Ge6OkG3TP92/iXi07TiwUwlyIaiHvPexNobUh2rFQy7SYb/p+Ik6hIPUy2kwyxhnjN
         TAH3nzkTV0oIXFfJV1LO03NsyP6pRrHkdyxvo6BhA4UuYpJR9IS0Ocek3dHF5fOQbe2M
         E+kmsRbYFRMZAvUpUhr0AWmnwO3vUFg2EIl0Ldury4DhMMp5YbrMDdwu28PHJKibxUo5
         +bGDnh55LrP3clGIESdgHhqCh7he/NfTDR3dwjcSegYyI5aSpSLLKEFbC+RoLe9YTy8L
         ax6lzqQwMWEWACTsIRNqnkG1otsY6sE9K+jgtJgWAyXeNII/nFdq2haVSLqZIjDkdNh4
         eaHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784546003; x=1785150803;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QN6Sa3FnT7k2MKcUIt4Usx9BRVJXnBuQBTO+EcPn68M=;
        b=Ta7iJVwSROs+/ZJsBHC5GrqUnLt1MsPcgmJ8OUGEkyumABX2jcK3o20n6Vlq9z65JM
         8RPSyVJIAkejoQOX+PEwlD96TN/fSGfS+UkfTomaTJJa8phFzOB2QduSnIOrsjaDXjOa
         n/Tn/BaIalRAAfdo4Mgqz4zPeNyHCAD2fr3J5JchKiQ2y5auLDx8Ln7iUpM/YU7Y7C0x
         qipOtj7rj47dY9wCjaHdgGXdw1Cd7gegkr5DUcOu+C4aXBGZrLOpOA1veoBGN6q2kgJW
         JvAcQVT+LfqvhlWWNj1J8tdvR7l1Hkgu5NRNdcu+n8KP+PMbTNg/BC1/vBgU+JZ7wzRo
         A/wg==
X-Gm-Message-State: AOJu0YzgZSk+MSj7tS4YAgR1dq16DoDFSXj2oLrLVNM3XJeWWgwF4QU6
	1zJkhdzu6Mf59KEK0KVlgkuLrVP7/F11OU6VV2t3FojJ0ckHGuuqolzTDqOPVEMOSL0=
X-Gm-Gg: AfdE7cmW9g0TOYoVo1YSsw+l+LC0oi38t2wGiH4LAvRXswyA3I6sw0vMbM2Fp1TtxKV
	YVqM9hcrdLM+T1ReBq1u/QYHR1CgCYvDT4WQhxgVNRsoHaAwV1ILWN8zicbs6wm6gpZa4k8w0yz
	hQve25HyIKCK5cep4LGmwAOXXm6dDEAmljqmarxKhyy4IEs3YVBPBDTaKPsuWm6WL2xfT0RF+eB
	X4395pZRA+9NWLrNMRX697GXM2yHXzi8OUM/r2v4NPYTIkabadWQQ59ygVSV66QkM735ushVdcS
	o0aarTaunIFEkfzDdiVcoh2fJ1/gME3t150pDQw7PObBR2qbfj4Ni3LO5w2Q6NLmKSJvX5jlpC9
	oHlTztKDHlx8HWmZwp/nBCehGS7BGA+wZEGmix+qp/P0/vmn1MtivPhLv1+mrwiX/TLSW44/p96
	Sg
X-Received: by 2002:a05:600c:3112:b0:495:472c:208d with SMTP id 5b1f17b1804b1-4954a41307cmr135152415e9.38.1784546003305;
        Mon, 20 Jul 2026 04:13:23 -0700 (PDT)
Received: from localhost ([2804:7f0:b765:c3e:cc5f:6c4b:db0a:5d2a])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c1eecc8e5bsm9088749e0c.4.2026.07.20.04.13.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 04:13:22 -0700 (PDT)
From: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
Date: Mon, 20 Jul 2026 08:13:09 -0300
Subject: [PATCH v2 3/3] libbpf: Search /lib64 and /lib in
 resolve_full_path()
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260720-selftests-bpf_fixes-v2-3-b450eda93dfe@suse.com>
References: <20260720-selftests-bpf_fixes-v2-0-b450eda93dfe@suse.com>
In-Reply-To: <20260720-selftests-bpf_fixes-v2-0-b450eda93dfe@suse.com>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, Shuah Khan <shuah@kernel.org>, 
 =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, 
 Christian Brauner <brauner@kernel.org>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1784545988; l=1421;
 i=rbm@suse.com; h=from:subject:message-id;
 bh=XLOtvvCv66YQSGuoLu3eRvzMzjzimYKdjqYj+ocM9dc=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgguRCc5X8/UX9M40lkMnr//aFGOhce
 x5ezt8MFNUFlqYAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QAtQoVs8IKXZ/WoGcNMf6XZxbYamJT38nyl50KUKsxxjuXmVJKzag8UU4v/8YhQKRvRJE4sCI9/
 G/ieYJUQyrQo=
X-Developer-Key: i=rbm@suse.com; a=openssh;
 fpr=SHA256:pzhe0fJpYLz+3cZ33FFPhIfaUElk9CXPFFXmalIH+1g

attach_probe/uprobe-lib and uprobe_autoattach selftests fail with "failed
to resolve full path for libc.so.6" on older non-usrmerged distros, where
libc.so.6 lives under a top-level /lib64 or /lib rather than /usr/lib64 or
/usr/lib. Add /lib64:/lib to the search paths, alongside the existing
/usr/lib64:/usr/lib and Debian multiarch entries.

Acked-by: Ihor Solodrai <ihor.solodrai@linux.dev>
Fixes: 1ce3a60e3c28 ("libbpf: auto-resolve programs/libraries when necessary for uprobes")
Signed-off-by: Ricardo B. Marlière <rbm@suse.com>
---
 tools/lib/bpf/libbpf.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 1368752aa13c..1ab939dfb7f0 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -12973,13 +12973,14 @@ static const char *arch_specific_lib_paths(void)
 /* Get full path to program/shared library. */
 static int resolve_full_path(const char *file, char *result, size_t result_sz)
 {
-	const char *search_paths[3] = {};
+	const char *search_paths[4] = {};
 	int i, perm;
 
 	if (str_has_sfx(file, ".so") || strstr(file, ".so.")) {
 		search_paths[0] = getenv("LD_LIBRARY_PATH");
 		search_paths[1] = "/usr/lib64:/usr/lib";
 		search_paths[2] = arch_specific_lib_paths();
+		search_paths[3] = "/lib64:/lib";
 		perm = R_OK;
 	} else {
 		search_paths[0] = getenv("PATH");

-- 
2.55.0

