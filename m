Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com [74.125.228.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9F44B4058
	for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 09:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789638026; cv=none; b=NFODpt9lLmjPY6MdSaA4eZfLLTYbaiX0S1F3okE7MCjybhC/rtGxxpMQPsyfBJ00nLPbRh+kMD0C+Kk06cHVAH06E+/bj2rB1xbzl/lvCfSUwTAcTd8XT05/9rBx3PGGpuU1Jo2ICJuoM3/eBeGaXeGfDGVCKv+6usLSoqScYR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789638026; c=relaxed/simple;
	bh=FyxOkEcHDQYoJLHkGJj9pLX7m8LSzsmIBN5qWqVag30=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Vs+Xe3VY/74fsGDwIhFHI89mIxiizm6mUCA75rwt+VhPMkkNmZyF+IjyfCFoDErT3d5GDIX+/5+RcocWxWWJfH3tF8vymZMUbAxxCNngO9vdlSRZ3RCmEk+LgPriodcwMFfAEliK3SSymfes0tCZmXuUJQ0SirNTbEO1u6ECSts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KtNJgVyh; arc=none smtp.client-ip=74.125.228.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KtNJgVyh"
Received: by mail-pz2-f42.google.com with SMTP id 41be03b00d2f7-cc4d04d740cso406541a12.0
        for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 02:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789638003; x=1790242803; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=drIUXJRcmosJe6dH4/Y3AT2c+DRvKWStOih464x6FUs=;
        b=KtNJgVyhk5JXkEg+DOun3GNTMLus8ZIV71zBB7Fur2ebDMq7yhS9m8h6xXi3Us2w/3
         mDYcLLIcqz5PBpR26S7ZSS/hYjjkZby8LA/vQxvows3DBs3Vra1vONLgKDRU0Gshw4jF
         yekO4sfYbFcpT7ComHMy7264t4bQWPm30jR/tIow9FRJkptWd8IeTUOpC+NkJpBi8AeB
         t9lBdxA2VFcZGPOhbb7k3Hb0LZW7m/YDd+t1E9NeT8AglSzRkPh61O6sUCrEoEAMPcBn
         5EPoEn2ljjIIv+/QOG/59h/6h2Hpa3RiVyxTj56HpPS7V0/1lRgfC/wrewedVDvu1Afd
         tIRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789638003; x=1790242803;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=drIUXJRcmosJe6dH4/Y3AT2c+DRvKWStOih464x6FUs=;
        b=ow/fljZvATm4KHg16l6vm/1efAjqoX/xzq0D6sgmbrtJ+OEwW7OqB84Ej+hNmskKHJ
         KQqFtv9N4R9PVvUrkrRb/PJF8iAhuOkFBe9ZOe4S9MMzBfqLqyCm022eURxm5Xjz+sCw
         D+xxtoZ5ZVZthaUestqXY01qMI7m3xUF4gTYWasMz17+jSFXJqBfjWqFL9A4YiaEaql1
         vC/0ciHfsEG01lPcEjPEuN2mG4aFhaMNE6pkffckg/yidCLyHDGGtsqKZm+Gb9ZBNesK
         7jD3WTjeWxKfAolAx4VNMa5WdVBWpNj1HTbJqC/A5vi5tfwN2XZY5yTIY2H0gvef5Gex
         gM5w==
X-Gm-Message-State: AFuF++nvbGSnGg3Nu8pQ69F9MxEbYctLlT2oPilI8CZpzgvl8Lp8ViXr
	a5E5tPe7wlgpO1Y43Iw/mNIhDQ4+VGQZ+0uCFBCwP7FxY+i00dMFNgBAY++XnBbhtdg=
X-Gm-Gg: AYBFou24O3HFIiSFaM1o1tyhtuZ+Xwb+05xh/pSOhc6kDTgxvoBs3g8IUErvlddIfDn
	03hitXH07AUYW6ZRbIlJLyjdykZL+yXi7os/W0m+LK1D/ZWbZ2yImxia2WAL1z71IX247iVVd5Q
	+1otukq0kXwqj/KctG+KEPxPrYvjy88N48TBWZ76OreGtjofo4W0JaFOOcF7AV3DWhqzC+Anqil
	id7n0xMvkpKr03BGHxFlu4qvrQeNmn2Gi9kLvSlbYYE5we+9rBdl+FoU/e9SZECI9jiDAzI8jD/
	GcnDX76y5f9cpDiI0V2uIcKSDkiCK2X0VSJMHAGEX4AgRKePqfg23zhIttXKhPYHbJX70Se346y
	OQKVInlocOSiqNz9xN8L3hquflBaZN0HsDfePRxwgD0az6og67AsvcSx9W41HV89A7CbK/ObnjO
	y7AJM+ehlJGwEmJNJmxVaN1jKjLZRygVZWKn6e+07eoAQlJX6vAV08X0z0lkwxS//xxtMjx3siy
	5EKvnBgxA==
X-Received: by 2002:a17:90b:46:b0:39e:35a0:9c0f with SMTP id 98e67ed59e1d1-39e35a0a211mr7280643a91.14.1789638003386;
        Thu, 17 Sep 2026 02:40:03 -0700 (PDT)
Received: from c79ofce.localdomain ([103.165.85.242])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e362e9402sm4192389a91.15.2026.09.17.02.40.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 02:40:02 -0700 (PDT)
From: Zhixing Chen <running910@gmail.com>
To: bpf@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Zhixing Chen <running910@gmail.com>
Subject: [PATCH bpf-next] selftests/bpf: Guard link cleanup in fexit_bpf2bpf
Date: Thu, 17 Sep 2026 17:39:28 +0800
Message-Id: <20260917093928.48495-1-running910@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

test_fexit_bpf2bpf_common() can jump to the common cleanup path before
the link array is allocated, for example if bpf_prog_get_info_by_fd()
fails. The cleanup loop still indexes link[i] unconditionally, which can
dereference a NULL pointer and hide the original failure.

Guard the loop so the test reports the original failure instead.

Signed-off-by: Zhixing Chen <running910@gmail.com>
---
 tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c b/tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c
index 6262c81cdaa9..d2f2dcc0f2e1 100644
--- a/tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c
+++ b/tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c
@@ -164,8 +164,10 @@ static void test_fexit_bpf2bpf_common(const char *obj_file,
 		goto close_prog;
 
 close_prog:
-	for (i = 0; i < prog_cnt; i++)
-		bpf_link__destroy(link[i]);
+	if (link) {
+		for (i = 0; i < prog_cnt; i++)
+			bpf_link__destroy(link[i]);
+	}
 	bpf_object__close(obj);
 	bpf_object__close(tgt_obj);
 	free(link);

base-commit: 71b75648d1a21c0a6379741d00f41086ec95f14a
-- 
2.34.1

