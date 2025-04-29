Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE802D3F99;
	Tue, 29 Apr 2025 23:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745970791; cv=none; b=pPfV28H1q6P1wqbwbKw0CvgQ03S7TwnYRu0Zm10lPgnc17/TFCawaAjV4bSTGVmr1EJ1kmFtcp1tZ/qllfQRN/VhxQmLx79wdr2ZwzEJ4TXwheeC6m/MVtHaOj31KIoBJ1mk9D3nfC8bBTK3xFZPMs3vWFwzSn0lZQXjl2N70i8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745970791; c=relaxed/simple;
	bh=2oz50+X7QDKubf9DkwX20leuuzsNO+Ef9u69G8iUJdo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XMaAi9Yjb48f1DnocPtRWxkYTOp/7JO7ln2E2TdOpQ+thiBomusWOmTGicOPMwzlAi4HrSg7qJgvkq7Al0yekeTMk4Nu7vKJq3sLv6nRucrXg0FECW9vrqthwc5tmKGBDy37ksz75X9ze4p90Kf7uecS55NjzOnNAS7PhUzKzVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GpmTxcxz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GpmTxcxz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 474DEC4CEE3;
	Tue, 29 Apr 2025 23:53:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745970791;
	bh=2oz50+X7QDKubf9DkwX20leuuzsNO+Ef9u69G8iUJdo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GpmTxcxzpAAavpeChUs/pExfjRwHXrfZ7tPdI3WNkHQRVmZ5Ih0B8lgfRY6EP40AW
	 TC79zJIS+HX7UoGcjWXucw9/7zDGqVbxELMcV7G4L6w5t4pJAAEVoaop+EsPc949nh
	 ZLsd7RlHCm6l8gC+Uq65A2UEBCM0kveNBOBthRL1edN32aKJ35GiGpM75eegB0cKx9
	 B5RVSWsqiOq0/E17/1asBcD9QeUCUZIU1FN5fMIbiE3yf66EN+luBAjjyRvu8pdrlA
	 TusyLbsZknAdAxavAfBnSNXtpuljGmxXma+zf50mytQLurj4MQzx0pLTc22B0/+eaA
	 upSCtDFM+yTkg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ihor Solodrai <ihor.solodrai@linux.dev>,
	Andrii Nakryiko <andrii@kernel.org>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	eddyz87@gmail.com,
	daniel@iogearbox.net,
	shuah@kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 19/21] selftests/bpf: Mitigate sockmap_ktls disconnect_after_delete failure
Date: Tue, 29 Apr 2025 19:52:31 -0400
Message-Id: <20250429235233.537828-19-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250429235233.537828-1-sashal@kernel.org>
References: <20250429235233.537828-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.88
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

