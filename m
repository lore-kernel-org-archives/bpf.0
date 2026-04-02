Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682333191BB;
	Thu,  2 Apr 2026 06:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775109859; cv=none; b=ACvtzyCCbBW6DluKJPmgklTAGbHnhdz3tLB836eOaoTwia0vOSByQcGE1GiwGFXvKjDlyJla41qDcLs53Q9+5tdNyTN+iptzJJCLA0igfOuKqSAzg/3A4Ze7yAB7IJIzvuSKHAyJ59l62Nx+9PzXjHwS2hfMrFuYREWEEqxMYYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775109859; c=relaxed/simple;
	bh=YX13sLn6pbupoGA3DKDkyfLdyhL4r9A4RGREkwORFZs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nXfGvVmITKUqrp1b0lVbYCrNR/pOvb0syxvDKxTU2CzJtg4bSwuLAM8iKbx8X3E9khVcF94qmAuYgrtJ8biBFrw0QsFAdaWX82aJXKB5fq4skRZVzAVEdB+XSzrOg0ge9yypw2HAG1XFKt1qUIoPc/m5bSlSOBGCXTRbGZxIZz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=bnkOl+4z; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="bnkOl+4z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1775109824;
	bh=yJVKkdX5pQnrGRfKGg0vycfLU3Us3QpJnv9UWNiLO1Y=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=bnkOl+4z5ispl4+DuE3QldUNGC2CFth3zDGQbzfJbPlcbmo7v6o9YOsb7+JvIWGS/
	 /B/BzeQN1xB4fr7nlYEFjN+fhvDE5Nx1dUA2elJ6Fh32rGG/Fi42JtN+3LJO37MAty
	 ZgCd6xqJtc7gEf4teQ0wLPLgOF9uOk/k7UsQ4JeU=
X-QQ-mid: zesmtpip3t1775109811tec0d8b89
X-QQ-Originating-IP: 1deptUJdddSIGEE04lN3IerCh2Q8X3KSeZ4XfiA50Hs=
Received: from xulang-PC ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 02 Apr 2026 14:03:29 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 15530819969611979821
EX-QQ-RecipientCnt: 20
From: xulang <xulang@uniontech.com>
To: martin.lau@linux.dev
Cc: andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	dzm91@hust.edu.cn,
	eddyz87@gmail.com,
	haoluo@google.com,
	ihor.solodrai@linux.dev,
	john.fastabend@gmail.com,
	jolsa@kernel.org,
	kaiyanm@hust.edu.cn,
	kernel@uniontech.com,
	kpsingh@kernel.org,
	linux-kernel@vger.kernel.org,
	paul.chaignon@gmail.com,
	sdf@fomichev.me,
	song@kernel.org,
	yonghong.song@linux.dev,
	Lang Xu <xulang@uniontech.com>
Subject: [PATCH bpf v3 1/2] bpf: Fix OOB in pcpu_init_value
Date: Thu,  2 Apr 2026 14:03:22 +0800
Message-ID: <979DE74421E5836D+20260402060323.1995132-2-xulang@uniontech.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260402060323.1995132-1-xulang@uniontech.com>
References: <20260402060323.1995132-1-xulang@uniontech.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:uniontech.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: Mx4bSM6s4wfd2ph7+OKP/Q32A250a+33swQN3Weg6TfGQlrMl4/1DlTn
	zH6nO2/MyGnTHT14QBCRM/zWUkoUZNCuaxFrXVhWlTGwrhJ0SyGZeXi5pwokqMBZ89JHOjP
	o7+AHQJsBogqrIk/XsLKqaky+9/uCRRtRcC89b9OW17gWHCPRP5KOPiEPRXEXkcUM8I81jI
	xkcp8cX/ood8+BW14g6wxXaONegOze1/57oKcrTJdz1PmTnPzIKnZ84ZOgZqkmTWt0/0dHg
	afPkR2RL+a/5lpFqApMafvLSuRm407quGWFcU2OukZQ9+mySpR0Dx8WYtdGLX5AYhSZcEmm
	q/wNzwU8oBgBdKFA9IKOp3mNa8+PqbSxdggR6Ru2FAAFIS6Z1YGzSvwZObMNrZoiN3+LKjY
	h1tkrKJ2O17FUEbGEImK+TWnis9kyHvxz8wHbr39oSxXRPYPwKIrXCnfiSZFl7rbPIC7wUl
	ZRpAAVP04KwHLfVFVWJ7jTdADtXs8cSO7y0+PPVVMSb3oXZxh987prB4p1y6vx7ZfQFhnCC
	X6HOPChC/0mG35Wni0JinBzFUbzUORWQH0VOmzwW2iHZeBruwllCgEBCRUV0K/VkzF/oTOQ
	MCDWX9+c31kgJ3b58F077kZ27eGGrKEurGfaw3Pnjjjx+F55Nqg+5CVsjL/B9co4Tj9pMfR
	J+xEue8Gagbtiuz9tfBsvQHys7UopWgL2N1bqUUNBVPLTNnZ23yL9VXvXoChnibkTAtHVzi
	+I5rdWLPTv5VbBj66Nmsyz/EUcdHenDGOu7RbdLY9PLG3wodBE1ZeAdMZchgW60QDOPBlku
	kLUAuakxyFffRZgZdt/XWbACrQKoMn4oWNfVxZBXbvseSXZ2W7f1df2kTIkEcNHzYUxp1Yt
	X+Q5c5qbUBFDPXHzkKszroq78iN4vpwx1YaudOjIM6YgiXaWoBGmExJBHQyr9f16TEJOeb7
	dy1hD2ek2Qp4NrSln9x+xWo5of6XC1qWpg3aM1zUy5UjZK+J1mOTUlTZQM9+OZCfhcd3tIp
	sYyVMkttFBT+6mXsRvSTknh4TNXCoFwwLcLIQd2y3vu0h2bu7OEUDghQOce11cRxCaR91HU
	nNtaH7nkgtky180vd1ndQGTPg7Op+UPk65wrkzqQv6c5QrKuaH1Wl3ZBSe9aH7B0ojoUM48
	ImJBp/7/pdRLcbY=
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
X-QQ-RECHKSPAM: 0

From: Lang Xu <xulang@uniontech.com>

An out-of-bounds read occurs when copying element from a
BPF_MAP_TYPE_CGROUP_STORAGE map to another pcpu map with the
same value_size that is not rounded up to 8 bytes.

The issue happens when:
1. A CGROUP_STORAGE map is created with value_size not aligned to
   8 bytes (e.g., 4 bytes)
2. A pcpu map is created with the same value_size (e.g., 4 bytes)
3. Update element in 2 with data in 1

pcpu_init_value assumes that all sources are rounded up to 8 bytes,
and invokes copy_map_value_long to make a data copy, However, the
assumption doesn't stand since there are some cases where the source
may not be rounded up to 8 bytes, e.g., CGROUP_STORAGE, skb->data.
the verifier verifies exactly the size that the source claims, not
the size rounded up to 8 bytes by kernel, an OOB happens when the
source has only 4 bytes while the copy size(4) is rounded up to 8.

Fixes: d3bec0138bfb ("bpf: Zero-fill re-used per-cpu map element")
Reported-by: Kaiyan Mei <kaiyanm@hust.edu.cn>
Closes: https://lore.kernel.org/all/14e6c70c.6c121.19c0399d948.Coremail.kaiyanm@hust.edu.cn/
Signed-off-by: Lang Xu <xulang@uniontech.com>
---
 kernel/bpf/hashtab.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index bc6bc8bb871d..fb8123cfa5ec 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -1056,7 +1056,7 @@ static void pcpu_init_value(struct bpf_htab *htab, void __percpu *pptr,
 
 		for_each_possible_cpu(cpu) {
 			if (cpu == current_cpu)
-				copy_map_value_long(&htab->map, per_cpu_ptr(pptr, cpu), value);
+				copy_map_value(&htab->map, per_cpu_ptr(pptr, cpu), value);
 			else /* Since elem is preallocated, we cannot touch special fields */
 				zero_map_value(&htab->map, per_cpu_ptr(pptr, cpu));
 		}
-- 
2.51.0

