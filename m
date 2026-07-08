Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF2CD4C8FE4
	for <bpf@vger.kernel.org>; Wed,  8 Jul 2026 18:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783536073; cv=none; b=VkDUcCRI31VaBeTSBoTqq5hBaJAIkI6/ZXzkF8E1CZbCOt4Izyg8MR/dqa3HxwbPC66lmr6NLG7tMZzUcfa600IcwIHaWLlCnfFghYb8KmPl2LBZxspRgKHTGIdLtfBe7/i+qj5fuEk034ZBMEYwzWCpi5ZsUFhnZ6TUoKl9t24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783536073; c=relaxed/simple;
	bh=9wINvG3GwsOR8TZB0CNO1URRZv0LBVCxJEpMwVP09Sg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OhOpw7F4BSNlzJm9IyRIlBIAvqjxlRkWRCioSxb51DISdgfzh7+6ZfQOLgCm3pJsBW53dVYCALpcv8jcpmCe5E2CuRzIMqM/pVOFsuVf7DmXB04AFXhH9Kfxst9i/79sQ5q2sNsjp7wC9ajtaXZHd9YsGhtw7c3HN+LxaVIFQXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=ADOlJNge; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="ADOlJNge"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=dOhHhmHK5CAC8SmYdPP4x11GeOWPiyiHvsU5js6DPXU=; b=ADOlJNgePapfJmRaiJslbyXTg6
	YCbBb8fBCdpcNb6Kv8nX1GEQubTYOicmjHTRcwa7xtKPvxnOZ0g93NiNnfwRX/2UXGgsdp2+GKpUl
	7l44NETAd9MsAMxl4AUly9NlyDkLyIJYkoR8LcYoCb12afhDdAdTZ8Whp3V1ROei9ElpgLjedH6Xn
	ejFHJ0+MyCNSifiDyJXghTPTlzL7TK6mdoEHCxNwngxaNF5tWedwFGHruEBLdEL+BOUB4t7pJOsQk
	yYDlsmUGj/gF/FHa1CRBadZ3bes/IXEBOFqMRM1JIQWBVWQ7NEtqf0GZNECovi5DjTFZuo0wFvf8s
	60wl4gMA==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1whXCm-0003uU-1L;
	Wed, 08 Jul 2026 20:41:08 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: memxor@gmail.com
Cc: ast@kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next] selftests/bpf: Close fd on unexpected success in signed loader
Date: Wed,  8 Jul 2026 20:41:07 +0200
Message-ID: <20260708184107.369182-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28054/Wed Jul  8 08:24:53 2026)

The signature_enforced, signature_too_large, signature_zero_size and
signature_bad_keyring subtests load a program that must be rejected,
but leave the fd open if the kernel unexpectedly accepts the load:
test_progs asserts record the failure and continue, so the fd would
linger for the rest of the run. Just close it.

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 tools/testing/selftests/bpf/prog_tests/signed_loader.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/signed_loader.c b/tools/testing/selftests/bpf/prog_tests/signed_loader.c
index 0019492cf07a..77381d345435 100644
--- a/tools/testing/selftests/bpf/prog_tests/signed_loader.c
+++ b/tools/testing/selftests/bpf/prog_tests/signed_loader.c
@@ -326,6 +326,8 @@ static void signature_enforced(void)
 		fd = load_loader(f.gopts.insns, f.gopts.insns_sz, -1, junk,
 				 sizeof(junk), KEY_SPEC_SESSION_KEYRING, 0);
 		ASSERT_EQ(fd, -EBADMSG, "invalid signature rejected at load");
+		if (fd >= 0)
+			close(fd);
 	}
 	gen_loader_fixture_fini(&f);
 }
@@ -575,6 +577,8 @@ static void signature_too_large(void)
 		fd = load_loader(f.gopts.insns, f.gopts.insns_sz, -1, junk,
 				 64 << 20, KEY_SPEC_SESSION_KEYRING, 0);
 		ASSERT_EQ(fd, -EINVAL, "oversized signature rejected");
+		if (fd >= 0)
+			close(fd);
 	}
 	gen_loader_fixture_fini(&f);
 }
@@ -594,6 +598,8 @@ static void signature_zero_size(void)
 		fd = load_loader(f.gopts.insns, f.gopts.insns_sz, -1, junk,
 				 0, KEY_SPEC_SESSION_KEYRING, 0);
 		ASSERT_EQ(fd, -EINVAL, "zero-size signature rejected");
+		if (fd >= 0)
+			close(fd);
 	}
 	gen_loader_fixture_fini(&f);
 }
@@ -614,6 +620,8 @@ static void signature_bad_keyring(void)
 		fd = load_loader(f.gopts.insns, f.gopts.insns_sz, -1, junk,
 				 sizeof(junk), INT_MAX, 0);
 		ASSERT_EQ(fd, -EINVAL, "signature with bad keyring_id rejected");
+		if (fd >= 0)
+			close(fd);
 	}
 	gen_loader_fixture_fini(&f);
 }
-- 
2.43.0

