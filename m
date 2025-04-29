Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE1A2D7AF9;
	Tue, 29 Apr 2025 23:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745970815; cv=none; b=SceYk6Co0JZLMYCz99KbSbhwx8VoZFjUUsnKfbWn+dN2hHF6AHkUFIgOB5wBjNG26w+qSQTxS+JimGY3TG7jxsef300EnW6wZwAmyWqq8VlkH5VB9fxGlLmMX0ikQR70QqIHJv7UubvpZ2RcCUu0JU42NthT2HtDgZduDDjmBNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745970815; c=relaxed/simple;
	bh=2oz50+X7QDKubf9DkwX20leuuzsNO+Ef9u69G8iUJdo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uWtl3WJVc5ppIOGiW54M7WHsxp+rCEl+mkqK+NxXyUzItuBey/m/hQuhM3CXuGoN7YRKLf9N6n/IojUG8/sps6awGM7LR5CWArh2pM2tHqG92reAnviXFWXyu9PAevbkmEVBTq82iQ7UlRdapSEkytN8guuludwyjBwNqMG1SRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bmp1L88j; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bmp1L88j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ACBDC4CEE3;
	Tue, 29 Apr 2025 23:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745970814;
	bh=2oz50+X7QDKubf9DkwX20leuuzsNO+Ef9u69G8iUJdo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Bmp1L88jAg5w+kGQisxpesGo461i6lUfvbWt9OaUXjzgIHXkTiSCx/Hj5mwqu/RHp
	 5/ptHCYNZ+9zupIpCn5WmwigMD5jomEqMiuIcM4npHYziZm+2lgKk58UR+o6va0LE1
	 Ykeqf5w1NMcHqNqgW3NPe4++8tusRe/EOydT8LfapsHd9WQrcKibSoYho++/siv7R+
	 vDDATZQk+epZidF5QuGwYYozwmL5cjR8TZHj/UY9vqc9CH2Q1mbV0dAU5draBlPEoL
	 tDteDfqVUM10ICr8Wqo9DHJ9xuFn5ChM8XSQb8XdTj8AvqRQZeDx1BXiJlyyN4/73F
	 Noe6x5tn3xwvg==
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
Subject: [PATCH AUTOSEL 6.1 08/10] selftests/bpf: Mitigate sockmap_ktls disconnect_after_delete failure
Date: Tue, 29 Apr 2025 19:53:13 -0400
Message-Id: <20250429235316.538129-8-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250429235316.538129-1-sashal@kernel.org>
References: <20250429235316.538129-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.135
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

