Received: from out-zbxj-a76.jellyfish.systems (out-zbxj-a76.jellyfish.systems [198.54.127.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FBD1377A93
	for <bpf@vger.kernel.org>; Mon,  7 Sep 2026 05:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.54.127.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788758093; cv=none; b=XUu45ZQrV4FqxIPGzjQCngV0yvS2MI8obgYYmzXYSFffEiUQFkVIuzH1gdMO46u46s2g0FfQFaTH75GbyhDKy2ZF+fb2cknK9QhLMjnAaeASMz67godPTJz3j3AlhrXhm3t7KPI7kV4jbNivBLfqxPzMgyXc4f1zcEtpb1KVsMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788758093; c=relaxed/simple;
	bh=omCVoJVAA0RtY4Ob43UzTzQ9Ne9vNj5kvsSNu6Vb5vI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qn3b2gyndXMYzKGLfaM7X8ZZEGPp4KRo08nXTIbmwnU35wO1LT7qS02foG+VcWcSq201sxFKYrm5vUcDHnqw9wYUf7PgQQV0NDQi69gbPi6SyvXXieUiNHtgaLHO3FLcy1VRomW5ECAGC7z9LvlijKx3bNd4t9ttEzJkx7dGIRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tychen.cc; spf=pass smtp.mailfrom=tychen.cc; dkim=pass (2048-bit key) header.d=tychen.cc header.i=@tychen.cc header.b=kt56i6oE; arc=none smtp.client-ip=198.54.127.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tychen.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tychen.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tychen.cc header.i=@tychen.cc header.b="kt56i6oE"
Received: from fedora (unknown [23.142.132.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.spacemail.com (Postfix) with ESMTPSA id 4hdZxy5WdFz6tlG;
	Mon, 07 Sep 2026 05:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tychen.cc;
	s=spacemail; t=1788758088;
	bh=6SAwKz5KVLY3787HEo87FEj/EUCZ12vDs8Aqm7FCTmo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kt56i6oEJn9hIS5U9l5joN2KVWIh9EN1iKpnh6Q7cCta5ihYILBgT+1nTYxdNgeWa
	 r5hmHkfLQdVWnW5kXnVRS1JUiDK3mSq7YlBEb2cpIGwnPoVeTXIJlnNfqrjkAmdfgx
	 c5GtXAvEb0vQ3kKy3ouDEJ0BFNEgyQux7w+Gfry8dA9ORI1i34dAlFwMCG2LCbomTN
	 WWOfjKI/5Mq6X/3pHspJwfocmr7cKOoqAPgaHhjjqAJQESPBdov3gDg/GCaa6giKYH
	 qwkfZ9ER4qqJc6CqUoY/ZhwVETNpMmqHq3QRRvpKEpV4+oXvMCv9aa+mWbJHn+F59c
	 ibLf2UqFzCTdQ==
From: Tianyi Chen <hi@tychen.cc>
To: bpf@vger.kernel.org
Cc: qmo@kernel.org,
	linux-kselftest@vger.kernel.org,
	hi@tychen.cc
Subject: Re: [PATCH bpf-next v3 2/2] selftests/bpf: Cover recursive bpftool map dumps
Date: Mon,  7 Sep 2026 13:14:36 +0800
Message-ID: <178875781913.42294.15961579600118750680.02-recursive-helper-comment@tychen.cc>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <c0f83aa30c83e841418eaee2d442a193f73720c3e9288298ed6484e9b0d9c8b8@mail.kernel.org>
References: <178874362960.1415955.11629203769007485967.recursive-v3-2@tychen.cc> <c0f83aa30c83e841418eaee2d442a193f73720c3e9288298ed6484e9b0d9c8b8@mail.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Envelope-From: hi@tychen.cc

Thanks. The helper on the original base did not NUL-terminate captured
output, but the current bpf-next helper does. The comment should describe
only why this test strips the newline, which is true for both versions.

I have made the following local correction for the next full revision.
It changes no test behavior.

diff --git a/tools/testing/selftests/bpf/prog_tests/bpftool_map_dump.c b/tools/testing/selftests/bpf/prog_tests/bpftool_map_dump.c
index 9c88743a8f8..db547a68d0a 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpftool_map_dump.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpftool_map_dump.c
@@ -16,7 +16,7 @@ static bool dump_map(__u32 id, const char *options, char *output)
 	if (!ASSERT_OK(get_bpftool_command_output(command, output, OUTPUT_SIZE - 1),
 		       "dump_map"))
 		return false;
-	/* The helper doesn't terminate or strip the output. */
+	/* The helper leaves the trailing newline in place. */
 	output[strcspn(output, "\n")] = '\0';
 	return true;
 }
