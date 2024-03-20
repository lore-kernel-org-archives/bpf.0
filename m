Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C9D12582
	for <bpf@vger.kernel.org>; Wed, 20 Mar 2024 01:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710898512; cv=none; b=AtS1323OWilyV2f4F0O3S3hDS0CLSSLasnbrmMjqfONC7W4NY+6JPg8/Ud/8T7jGwx4UsGI9dBjR3KeaAW8y3MMWzxPH4o81s6EWa5v8nTTLu6it/yzZRur3B83ED3ETWvZi0Hzfw7WdqsVSLkk5k/3Ff+bEcZqBCbhwf0mnYsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710898512; c=relaxed/simple;
	bh=+JZW7mlVHEIfHERIkmyrVWgB6SU1LIKxUGoC5ilmbiY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qFAiXRx4ZjmTt0zwjqTQuRJC3uMzZc38mPwvuO/3jOUVRjqrJHxg77BVUlfptsgJBYEJuerJumRLu53HLdVCB0Hx82qj/u+JDSjCFQX9dz5KxUt1Gl5jMB7YLpDTD3Ej6R6Fxz4aQ9L6cQdfVCbFtm3ULKmbruHk6EX6fBOVBe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gjYHhadi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gjYHhadi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FA39C43390;
	Wed, 20 Mar 2024 01:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710898511;
	bh=+JZW7mlVHEIfHERIkmyrVWgB6SU1LIKxUGoC5ilmbiY=;
	h=From:To:Cc:Subject:Date:From;
	b=gjYHhadiD1Lvu5nVz36xavZYRrrZN00hUmJwOK+b6xdcE5E6oWRTIgRcGOvzZ+0bQ
	 TBoRQmokerggDFMzNgH8TA29WSLQcklQ2mhfCn3na88EIYTdy0mr8Xu2NWsahmmILO
	 FH922hVSgOzcGnEGdBGUTSb7gQB1/pmK/6l+C/HLyROlI0zKaEAad5tOOD5YiEtGcd
	 0Yfuaw5HdQfhTKQ9gIrSNyeROKQLpsn/MiFOk/2x7qCCVQUXzWR9/VVabW5TEjMT0O
	 467Zu/xi1+GpRyzbxYKhIh6KBsCDibxA9c6oVMHNx9n3urDCmTDq7H66J2BWt8ySWj
	 gTMIVJ3QwwjNQ==
From: Quentin Monnet <qmo@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	bpf@vger.kernel.org,
	Quentin Monnet <qmo@kernel.org>
Subject: [PATCH bpf-next] bpftool: Remove unnecessary source files from bootstrap version
Date: Wed, 20 Mar 2024 01:34:57 +0000
Message-Id: <20240320013457.44808-1-qmo@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit d510296d331a ("bpftool: Use syscall/loader program in "prog load"
and "gen skeleton" command.") added new files to the list of objects to
compile in order to build the bootstrap version of bpftool. As far as I
can tell, these objects are unnecessary and were added by mistake; maybe
a draft version intended to add support for loading loader programs from
the bootstrap version. Anyway, we can remove these object files from the
list to make the bootstrap bpftool binary a tad smaller and faster to
build.

Fixes: d510296d331a ("bpftool: Use syscall/loader program in "prog load" and "gen skeleton" command.")
Signed-off-by: Quentin Monnet <qmo@kernel.org>
---
 tools/bpf/bpftool/Makefile | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
index e9154ace80ff..00c704423539 100644
--- a/tools/bpf/bpftool/Makefile
+++ b/tools/bpf/bpftool/Makefile
@@ -183,7 +183,7 @@ HOST_CFLAGS = $(subst -I$(LIBBPF_INCLUDE),-I$(LIBBPF_BOOTSTRAP_INCLUDE),\
 
 BPFTOOL_BOOTSTRAP := $(BOOTSTRAP_OUTPUT)bpftool
 
-BOOTSTRAP_OBJS = $(addprefix $(BOOTSTRAP_OUTPUT),main.o common.o json_writer.o gen.o btf.o xlated_dumper.o btf_dumper.o disasm.o)
+BOOTSTRAP_OBJS = $(addprefix $(BOOTSTRAP_OUTPUT),main.o common.o json_writer.o gen.o btf.o)
 $(BOOTSTRAP_OBJS): $(LIBBPF_BOOTSTRAP)
 
 OBJS = $(patsubst %.c,$(OUTPUT)%.o,$(SRCS)) $(OUTPUT)disasm.o
@@ -231,9 +231,6 @@ endif
 
 CFLAGS += $(if $(BUILD_BPF_SKELS),,-DBPFTOOL_WITHOUT_SKELETONS)
 
-$(BOOTSTRAP_OUTPUT)disasm.o: $(srctree)/kernel/bpf/disasm.c
-	$(QUIET_CC)$(HOSTCC) $(HOST_CFLAGS) -c -MMD $< -o $@
-
 $(OUTPUT)disasm.o: $(srctree)/kernel/bpf/disasm.c
 	$(QUIET_CC)$(CC) $(CFLAGS) -c -MMD $< -o $@
 
-- 
2.34.1

