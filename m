Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE792BD92E;
	Tue, 29 Apr 2025 23:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745970747; cv=none; b=o3f4j51wXmAwZDZLmuRqG7tzG6Si+eHLHhAQgzc5L97RKSoiBc0ZmzIxHG8XZoLzNuzLfK5fMzhrtc0Eo99rDIcPIcMUSYtyHof3X/yuMbMMUDwmtz/ld4y6yKmudWRVuysBynEQZgBfwd+fzsoR2jcYGPoSCSzEwGbZW1ccDyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745970747; c=relaxed/simple;
	bh=2oz50+X7QDKubf9DkwX20leuuzsNO+Ef9u69G8iUJdo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aCvy9NKSwNcX859W+606LHEwPcrxBb+EFgHi8koEAa6FXSQ+zyRub4xJ2UpC1NxIVgxh/KW9YKGFAybiMRdwQ0mjGA17gbrMi3g9uy+kptTKsiicVMA917rwlLkt/AIQTlwNxuCSAoK04t+r/VXV3IGNparo8nE3e6c91RuJEuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MIrNEucn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MIrNEucn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AD57C4CEE3;
	Tue, 29 Apr 2025 23:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745970746;
	bh=2oz50+X7QDKubf9DkwX20leuuzsNO+Ef9u69G8iUJdo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MIrNEucnEJFIbvfytmtsi7O/ncakSMtj0ZVqeVmimfLxbCYSr/VbGtsAbGmCcS8BM
	 CenmZS4Tf9nz+YQIpcoEKXXhJQuSdlRqybWxh90zw+w0zep1bSEJIuIHMZh8hTpdZm
	 RJpniVdY3iEajOsC3VSl9PzdiF3o/wm4M8p96tASRaGj0pcRB+OZ6ZSQHx3HLm/WGj
	 2tHtDCdCZeOPA6ctVfsXUczOKPA0Ffpp1G+MlQF/OYfr170Bu3I13w/nBL6A2w03ky
	 NkmjwuId4HNlFFkhmz/evlPrZxVTaueksiUVXOoQMrCijn9u6NCudu8NoX+Ci8LcMq
	 WtlOJKv/ZAHjg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ihor Solodrai <ihor.solodrai@linux.dev>,
	Andrii Nakryiko <andrii@kernel.org>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	shuah@kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 33/37] selftests/bpf: Mitigate sockmap_ktls disconnect_after_delete failure
Date: Tue, 29 Apr 2025 19:51:18 -0400
Message-Id: <20250429235122.537321-33-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250429235122.537321-1-sashal@kernel.org>
References: <20250429235122.537321-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.25
Content-Transfer-Encoding: 8bit

From: Ihor Solodrai <ihor.solodrai@linux.dev>

[ Upstream commit f2858f308131a09e33afb766cd70119b5b900569 ]

"sockmap_ktls disconnect_after_delete" test has been failing on BPF CI
after recent merges from netdev:
* https://github.com/kernel-patches/bpf/actions/runs/14458537639
* https://github.com/kernel-patches/bpf/actions/runs/14457178732

It happens because disconnect has been disabled for TLS [1], and it
renders the test case invalid.

Removing all the test code creates a conflict between bpf and
bpf-next, so for now only remove the offending assert [2].

The test will be removed later on bpf-next.

[1] https://lore.kernel.org/netdev/20250404180334.3224206-1-kuba@kernel.org/
[2] https://lore.kernel.org/bpf/cfc371285323e1a3f3b006bfcf74e6cf7ad65258@linux.dev/

Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>
Link: https://lore.kernel.org/bpf/20250416170246.2438524-1-ihor.solodrai@linux.dev
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/bpf/prog_tests/sockmap_ktls.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_ktls.c b/tools/testing/selftests/bpf/prog_tests/sockmap_ktls.c
index 2d0796314862a..0a99fd404f6dc 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_ktls.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_ktls.c
@@ -68,7 +68,6 @@ static void test_sockmap_ktls_disconnect_after_delete(int family, int map)
 		goto close_cli;
 
 	err = disconnect(cli);
-	ASSERT_OK(err, "disconnect");
 
 close_cli:
 	close(cli);
-- 
2.39.5

