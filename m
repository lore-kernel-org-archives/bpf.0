Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C7E12DC323;
	Wed, 18 Feb 2026 12:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771416115; cv=none; b=cZ5wfGtYnY2p5DnCDXJPgaxAttNU8WfEb7Y0YnQKpkJHjbaKFOWpz7k84DXaNACUn4q7pYmaD6VAKFG066OtoYCbDxPZ4/zoCIX0gRzZvbdbea6OrfSFfgoXrYf+X1HFfm73ICzJC1BI9r6PQ+hJEgDTwa6oCZMVVSzxkJJAAi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771416115; c=relaxed/simple;
	bh=hwo75hzr9UpfvK2MdDMYdnKzKKS3Lj3XB2mQQM63I1Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=RLKIxwks7Kw0FsFHXgRwv9AYSkP21+ZLlu6tCXkg4a9n7Zg61Ij1jrMlzH+7PQCpS6Jaup60USbO6zqd/tL/x5FCcViN2QYvv5bqKhWnUVCGi7fm3idoDEmSp4tByfUKbPNrpS5Y1Ij7xAkzoDLNF5My0DU6PyERspHvGV+5wV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BhexMEBE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BhexMEBE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2861EC19421;
	Wed, 18 Feb 2026 12:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771416114;
	bh=hwo75hzr9UpfvK2MdDMYdnKzKKS3Lj3XB2mQQM63I1Y=;
	h=From:Date:Subject:To:Cc:From;
	b=BhexMEBETX9K4JwR/Kz4GKBnhzaZKp0qvmMXUb0dFXpTZU/6Z7iWr4BQcz7azq+zM
	 /0wGoutno9h6JovA40VG1xz1HYk46/vF9TP7Y2I/CmAfSK8KEUYpQNbCXvT3KLtbdy
	 0/CaIRyn/cp9Eo9D3JX4RaBnTPHEHiHQ2Y/L4MuVipo5IPvq0V32wyoPdXD4ni2p1x
	 /zHbyNNBjs5IpLJMNpueUOuTHqBxmwTZl5tRP4UWqNh7UqlsK8RyoIIWAVELq5lxsX
	 I9QivG27FDDPb31P+2A6dB2uGtqafy3kTa85Nt25kFRjRIMFEsAPOg3v2PrVQD0h3s
	 PG8RH/AwwNrgQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 18 Feb 2026 13:01:44 +0100
Subject: [PATCH bpf v2] selftests/bpf: Remove hexdump dependency
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260218-bpf-sft-hexdump-od-v2-1-2f9b3ee5ab86@kernel.org>
X-B4-Tracking: v=1; b=H4sIACeqlWkC/32NQQ7CIBREr9L8td8AJrW68h5NF1A+haiFQCU1D
 XeXcACXM/Nm5oBE0VGCe3dApOyS82sV4tTBbOW6EDpdNQgmeiZ4jyoYTGZDS7v+vAN6jVJpdpU
 XZSoDtRgiGbe30REqD1M1rUubj992lHmL/m1mjhzNMJPSA6mbZo8nxZVeZx8XmEopP8U+rUO6A
 AAA
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2977; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=hwo75hzr9UpfvK2MdDMYdnKzKKS3Lj3XB2mQQM63I1Y=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDKnrtK/s/H5l5N/Qxaf0n8TfH2haqTh3YRFW8La5KSv8
 ni5Kej0dpSyMIhxMciKKbJIt0Xmz3xexVvi5WcBM4eVCWQIAxenAExkcTcjw259qyg5NZvl7U5F
 T/tPNknF3mjycuE+fWe3zoTP6ovbWhn+x65v0Fh09GLOsQlf5TZsntIo9inEgiFAIelIt93ivhv
 5vAA=
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

Here, od is used instead of hexdump. od is coming from the coreutils
package, and this new od command produces the same output when using od
from GNU coreutils, uutils, and even busybox. This is more portable, and
it produces a similar results to what was done before with hexdump:
there is an extra comma at the end instead of trailing whitespaces,
but the C code is not impacted.

Fixes: b640d556a2b3 ("selftests/bpf: Remove xxd util dependency")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Originally, I was going to add a check to stop the build if hexdump was
not available, but switching to 'od' seems to be a better solution while
not adding a new dependency.

Because test_progs was not reporting why it became unusable, I added a
Fixes tag to have this backported, to help others. Feel free to remove
it, or even drop the patch if you prefer to stick with hexdump.

Changes in v2:
- use a shorter 'sed' command instead of 'awk' (David Laight)
- I didn't add Mykyta's Tested-by because the code has changed.
- Link to v1: https://patch.msgid.link/20260216-bpf-sft-hexdump-od-v1-1-f8cebd8eb9d0@kernel.org
---
 tools/testing/selftests/bpf/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index c6bf4dfb1495..6776158f1f3e 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -723,7 +723,7 @@ $(VERIFICATION_CERT) $(PRIVATE_KEY): $(VERIFY_SIG_SETUP)
 # Generates a header with C array declaration, containing test_progs_verification_cert bytes
 $(VERIFY_SIG_HDR): $(VERIFICATION_CERT)
 	$(Q)(echo "unsigned char test_progs_verification_cert[] = {"; \
-	 hexdump -v -e '12/1 "  0x%02x," "\n"' $< | sed 's/0x  ,//g; $$s/,$$//'; \
+	 od -v -t 'xC' -w12 $< | sed 's/ \(\S\+\)/ 0x\1,/g;s/^\S\+/ /;$$d'; \
 	 echo "};"; \
 	 echo "unsigned int test_progs_verification_cert_len = $$(wc -c < $<);") > $@
 

---
base-commit: 886bf921ecfc30f8f31341bc26560d8bf08b937b
change-id: 20260216-bpf-sft-hexdump-od-abd07a3bf026

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>

