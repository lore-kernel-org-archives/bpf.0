Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E818E26D4F7;
	Mon, 16 Feb 2026 16:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771259451; cv=none; b=dH8DuFzoatwG9bNvLJZZv/iejEkQqlCIi2GWvSKE68yJNOAnzdM7IrFnJXSvBoCADeZdI390ucj8faMgAUw6EvLor/IQ+VuVUKLSZjqd5I8XkjzLJ3KJbTzqhkaMXL8j2m5uu0vOvD/SONjhiNlh2IOW3Ot6MnPc9276/7RBSqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771259451; c=relaxed/simple;
	bh=MsKOd84lx8EjiCfSFR1Ya3sszEAE9ECuXfRSNEv16ws=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=N8ccrX+CO8GfcYjjWx4ai9pZQzGIBQ5hlfcotGKtkpZL8QWZXO+PPV/FB6sDUeLRnJlLeHQd+XGgbv0xEzRtHdn5Jt1Ld7ADbYVpRbCg+Tc/TKwH5FwSxDr6bnjcEDd67C8qpqW7BA/2VBg/K7UHh5OUDWBGxOpfUZjM6IPkmgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MjqksDIZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MjqksDIZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07703C116C6;
	Mon, 16 Feb 2026 16:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771259450;
	bh=MsKOd84lx8EjiCfSFR1Ya3sszEAE9ECuXfRSNEv16ws=;
	h=From:Date:Subject:To:Cc:From;
	b=MjqksDIZDTgSG5AN8vPNGTNRAzH6y5hI4HzgmmWzrvsoDNlgF/j+vFnZ+OqUccA1k
	 tNq9Xh3aIHu+di9WUBuzyG9d5eMQzNp78q6Mu9mYw1Gf+KkmBcxm0NmKkVIhhhpDCT
	 kX7O1rYKpppjZSTubUO6GkXwVapp0IoYfYUWBbDIs4CSOQ9sSJa7s9vgmoaJZ+AAXU
	 lcvk4Ir0P+ATovPtM+o3q0nMHYfXh82KkCOeuy4COtRbtwrcDcr/Us8jqWbQ3arQXy
	 VAkyXqcedRvPq0pZtvJQKPNf5c+IlgBS1fFMNqXoDZqFf1qcFl21Kb3NoQEUVoi5KW
	 H7umKkp5U1SSA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 16 Feb 2026 17:30:34 +0100
Subject: [PATCH bpf] selftests/bpf: Remove hexdump dependency
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260216-bpf-sft-hexdump-od-v1-1-f8cebd8eb9d0@kernel.org>
X-B4-Tracking: v=1; b=H4sIACpGk2kC/x2MQQqAIBAAvxJ7bsEMCvpKdNBccw+VaIUQ/r2l4
 8DMvJApMWWYmhcSPZz5PAS6toE1mGMjZCcMWulB6W5AGz1mf2Gg4u494unQWKdG01svDkgYE3k
 u/3QG8WGp9QOzbhYbaQAAAA==
X-Change-ID: 20260216-bpf-sft-hexdump-od-abd07a3bf026
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, 
 Mykyta Yatsenko <yatsenko@meta.com>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2728; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=MsKOd84lx8EjiCfSFR1Ya3sszEAE9ECuXfRSNEv16ws=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDInu5lfLK9Y+8iXV8r1/qQN8XxKzy2CLN73u8htufbof
 rX0hu8HO0pZGMS4GGTFFFmk2yLzZz6v4i3x8rOAmcPKBDKEgYtTACaSH8fIcCX6bcPqvWZT/Y6F
 zLyp85Ij8HenrqqC1R052a/fpnxYVMnwz+Cn+zNfm54Ft5dYu0nHnup4dfRNJtc3XfsOH+6e56I
 /uAA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

The verification signature header generation requires converting a
binary certificate to a C array. Previously this only worked with xxd,
and a switch to hexdump has been done in commit b640d556a2b3
("selftests/bpf: Remove xxd util dependency").

hexdump is a more common utility program, yet it might not be installed
by default. When it is not installed, BPF selftests build without
errors, but tests_progs is unusable: it exits with the 255 code and
without any error messages. When manually reproducing the issue, it is
not too hard to find out that the generated verification_cert.h file is
incorrect, but that's time consuming. When digging the BPF selftests
build logs, this line can be seen amongst thousands others, but ignored:

  /bin/sh: 2: hexdump: not found

Here, od is used with awk, instead of hexdump with sed. od is coming
from the core utils package, and this new od command produces the same
output when using od from GNU coreutils, uutils, and even busybox. This
is more portable, and it produces the same results as what was done
before with hexdump (without trailing whitespaces as a bonus).

Fixes: b640d556a2b3 ("selftests/bpf: Remove xxd util dependency")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Originally, I was going to add a check to stop the build if hexdump was
not available, but switching to 'od' seems to be a better solution while
not adding a new dependency.

Because test_progs was not reporting why it became unusable, I added a
Fixes tag to have this backported, to help others. Feel free to remove
it, or even drop the patch if you prefer to stick with hexdump.
---
 tools/testing/selftests/bpf/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index c6bf4dfb1495..5a618d14243e 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -723,7 +723,7 @@ $(VERIFICATION_CERT) $(PRIVATE_KEY): $(VERIFY_SIG_SETUP)
 # Generates a header with C array declaration, containing test_progs_verification_cert bytes
 $(VERIFY_SIG_HDR): $(VERIFICATION_CERT)
 	$(Q)(echo "unsigned char test_progs_verification_cert[] = {"; \
-	 hexdump -v -e '12/1 "  0x%02x," "\n"' $< | sed 's/0x  ,//g; $$s/,$$//'; \
+	 od -v -t 'xC' -w12 $< | awk 'NF > 1 {for (i=2; i<=NF; i++) { printf "  0x%s,", $$i }; printf "\n"}'; \
 	 echo "};"; \
 	 echo "unsigned int test_progs_verification_cert_len = $$(wc -c < $<);") > $@
 

---
base-commit: 886bf921ecfc30f8f31341bc26560d8bf08b937b
change-id: 20260216-bpf-sft-hexdump-od-abd07a3bf026

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>

