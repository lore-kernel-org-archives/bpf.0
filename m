Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60D240DFA6;
	Fri, 20 Mar 2026 15:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774021633; cv=none; b=HVbwZJelhaqazyOzj9qRlDGJ8hJ+w0VoW2xqGPEeSX7pXz/Ja+BjlV447OidLKVZi07pECKZt4DpEGMji2a7yDKorZlCxgNlp4Xw7JyeddXNGdmvIkklRKNHSo1dwpEpy2X4sP001wLhxjUJxSIFzxVhp6DT1KXtZMtbEE1PSQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774021633; c=relaxed/simple;
	bh=UtpvXJf+xyL8cZEWcxMrh/v+97mKecPSR1EHStznfxQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dCK6tHxOA3IuYQAeRnnz+vf+6KwEbaCeHSzHdd/4/uyUhLjFlUQDP/9HQytdrEEoWtUvgS+ECwSBcUEMyZD1Jm8TYJwPfj79LS9GqRLsNVSvvMFp9IlI4CObeXuHAcz9pdBnrYAtHK+mhXAlis8JvG6lwuTMpK2pEVY8NQrZsVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=czdof5jK; arc=none smtp.client-ip=192.134.164.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="czdof5jK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=em4EFFGOJBe1UC+3UI2zbTwDP/jy25xQfsRSPMh3Zzw=;
  b=czdof5jKAXQ/RFDqWSsug+Uo1tUR8ud4TGQVN7JZfFVp5Rf1PL71mnOr
   uYrDm9TzJ+fsTqYpD+oQ8lBsqKOEWOoLZwlMlO052qbFjMAY3jlP6UiS9
   7A9EAYwLHxejjxboaofscOxKr9cU0nTIywozmWp2wjvlfiMYLzcmLRp8w
   M=;
X-CSE-ConnectionGUID: 1o1WUNayR0Gmc9KWuHyh3w==
X-CSE-MsgGUID: 4/C+29DsQ2a7rwphhtlujA==
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=keisuke.nishimura@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.23,130,1770591600"; 
   d="scan'208";a="141908151"
Received: from nr-lil-536.grid5000.fr (HELO gros-99.nancy.grid5000.fr) ([194.254.60.35])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 16:45:58 +0100
From: Keisuke Nishimura <keisuke.nishimura@inria.fr>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Amery Hung <ameryhung@gmail.com>
Cc: Keisuke Nishimura <keisuke.nishimura@inria.fr>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] bpf: Fix refcount check in check_struct_ops_btf_id()
Date: Fri, 20 Mar 2026 14:02:20 +0100
Message-Id: <20260320130219.63711-1-keisuke.nishimura@inria.fr>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current implementation only checks whether the first argument is
refcounted. Fix this by iterating over all arguments.

Signed-off-by: Keisuke Nishimura <keisuke.nishimura@inria.fr>
Fixes: 38f1e66abd184 ("bpf: Do not allow tail call in strcut_ops program with __ref argument")
---
 kernel/bpf/verifier.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 159b25f8269d..278443118a23 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -24853,7 +24853,7 @@ static int check_struct_ops_btf_id(struct bpf_verifier_env *env)
 	}
 
 	for (i = 0; i < st_ops_desc->arg_info[member_idx].cnt; i++) {
-		if (st_ops_desc->arg_info[member_idx].info->refcounted) {
+		if (st_ops_desc->arg_info[member_idx].info[i].refcounted) {
 			has_refcounted_arg = true;
 			break;
 		}
-- 
2.34.1

