Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE56439D6DD
	for <bpf@vger.kernel.org>; Fri, 21 Aug 2026 21:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787348484; cv=none; b=gYHv2jUSeETBY5J0IWiub5W/YG7jMN5t9qVmaVL+VBFuhN3QEK1mp1N/3KRPdz0MJrOOuUeUZtT6Fs+3/TqiYuTuacYi392Regx7HqHhhBUAG4/C/a+mINP33a8P6DJJ1EDHODaRp1czP8QsNCpontSmWbuYopdNVaLdhEnCMDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787348484; c=relaxed/simple;
	bh=+x9WbfERZdOskOLET28DhPFWGo+anDsgUap0ponAF4k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Izq8NhUpWVkvPuh9BqMImT4MUk/FLt4XGhMR7PSySciKGAxRsbZgeJ7OK8A2XVAHhx6wsm0zcDCEPpYf3BnBpI9eJWQQ7lZqiXWE4/0bhP2kiGaAHs11/ldK2eD6/QlMHDPBkgqlKQAru+tC5ykn62dsAWIda+ehZDOUQR9G+pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=TZbsS0OJ; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="TZbsS0OJ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=8BuULVjail1D1lOGQq/B6O5KWN95fK8On9fo3eX1yjM=; b=TZbsS0OJCYLz9dXzj3rubCtY+b
	n6IqUUNTK1yELr07fqgBzUUAv8WjcJOqiqFQHe8ci9P7VzcearYei5vC9zrlNb6B0aPKVuqXN3INp
	/GqNcGbcslVd00oViyItxi8ILRm4Qyb6ZZRSIU34IVhm75XiNU4n/B7UPH85LR0Nh0Tz+Tyr+/+xn
	7IoGuHaOX0QqKXw9HktGUoZogrgZkf36VKdyLeevLAvskD4cnZxP001KxOliQMPTIoMHGHdl2frJa
	YPvXvYUj8MIl2Pcesgjb2b7J2Gqld43YxV8tW5cpLGZzhW5LBgfksG92kzNZ3isCoheSTcdJ7dazA
	wQ5BhtDQ==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1wxWzG-000Mqi-2W;
	Fri, 21 Aug 2026 23:41:18 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: memxor@gmail.com
Cc: brauner@kernel.org,
	kpsingh@kernel.org,
	ast@kernel.org,
	john.fastabend@gmail.com,
	a.s.protopopov@gmail.com,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next 09/11] selftests/bpf: Allow appending to guest kernel cmdline in vmtest.sh
Date: Fri, 21 Aug 2026 23:41:09 +0200
Message-ID: <20260821214111.1120748-10-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260821214111.1120748-1-daniel@iogearbox.net>
References: <20260821214111.1120748-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28099/Fri Aug 21 08:26:38 2026)

vmtest.sh currently hardcodes the guest command line, so there is no
way to ask for such a setting without editing the script. Append
$KERNEL_CMDLINE_EXTRA to it when set to it can be used for testing
BPF keyring:

   # KERNEL_CMDLINE_EXTRA="bpf.keyring_unsealed=1" \
	./vmtest.sh -- ./test_progs -t signed_loader

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 tools/testing/selftests/bpf/vmtest.sh | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/vmtest.sh b/tools/testing/selftests/bpf/vmtest.sh
index 6a3d026d76bd..e7e0b419a0b8 100755
--- a/tools/testing/selftests/bpf/vmtest.sh
+++ b/tools/testing/selftests/bpf/vmtest.sh
@@ -107,6 +107,14 @@ Options:
 	-s)		Instead of powering off the VM, start an interactive
 			shell. If <command> is specified, the shell runs after
 			the command finishes executing
+
+Environment variables:
+
+	KERNEL_CMDLINE_EXTRA
+			Extra arguments to append to the guest kernel command
+			line, for tests that need a boot-time setting. e.g:
+
+	  KERNEL_CMDLINE_EXTRA="bpf.keyring_unsealed=1" $0 -- ./test_progs -t signed_loader
 EOF
 }
 
@@ -286,6 +294,12 @@ EOF
 		QEMU_FLAGS=("${HOST_FLAGS[@]}")
 	fi
 
+	local kernel_cmdline="root=/dev/vda rw console=${QEMU_CONSOLE}"
+
+	if [[ -n "${KERNEL_CMDLINE_EXTRA:-}" ]]; then
+		kernel_cmdline+=" ${KERNEL_CMDLINE_EXTRA}"
+	fi
+
 	${QEMU_BINARY} \
 		-nodefaults \
 		-display none \
@@ -294,7 +308,7 @@ EOF
 		-m 4G \
 		-drive file="${rootfs_img}",format=raw,index=1,media=disk,if=virtio,cache=none \
 		-kernel "${kernel_bzimage}" \
-		-append "root=/dev/vda rw console=${QEMU_CONSOLE}"
+		-append "${kernel_cmdline}"
 }
 
 copy_logs()
-- 
2.43.0

