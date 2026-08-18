Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00ED377000
	for <bpf@vger.kernel.org>; Tue, 18 Aug 2026 06:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787033503; cv=none; b=QiwCFC96E2Ek4WNtlLHfQGUJ4sI/z7TpH/znWKEN4cGNVGvbZNB3bLcFk6ReUmJiboGrZk1DNxMwABMwbpd1aSVSfNyQjIAqoj9IWCCyTEZSIZgv89jL91BLlJbbd8vpdEf6d9DHSTxKXpGQuPBOXMz/gs7L9ktjUC19NKh2tCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787033503; c=relaxed/simple;
	bh=EiTxNmLl+X9b9Y4H9T9jDRdn/xt7Cayy26DXOTx5hf8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s0REbkj0VLluTANz747EzlxlqO6cEkFpJhg5nq99c+1XZWN/GgLgDlNmlcOZFVLWdL2SMPe6sNOnPeyoCEgGJrhi0/7m4xkd9GVAdRDk4MfDjfe7B8hPjd41WcWQstIbjC3y9UEtMb2/ZTEyY5gyltrd7qfTiX4O0VdFFA4RSz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fbv6zsw4; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fbv6zsw4"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2d0407aedd6so51889785ad.0
        for <bpf@vger.kernel.org>; Mon, 17 Aug 2026 23:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787033501; x=1787638301; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Edwx/E9+bRKmpGkg3wu9j7fjMN0VuqfNhhOccxzRCpY=;
        b=Fbv6zsw4UEXtchMsEb03qzSmmQPw7FdrQUWe2HqtWrWES1twaZbKD2aT4Q84VUW3Z2
         Du848dyhyzU1omKSNQCGqfOWjXt4tekx0FOoZGiIYujxqLm11QSm1C3ZjYsrWfY1i39C
         5xT1u2bbJ4rzJYihS06w8DZ/DRQD/bDkBjGCN/8dFYAmzJAODrAY3UQk5AJrdZ/7K9Db
         l60eQxHQySfCjBXCdlq9ljgMUZbVeAITxV1z67GV8oWvwXPJ6u81KRWF515TaarDioRo
         9lCGgh+oXd2R9bkLKM1A6oCTISEvgxuUsMJ1Tr6lkEvZVYnSbNXbt7O3KhEYTLV6djUY
         vg0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787033501; x=1787638301;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Edwx/E9+bRKmpGkg3wu9j7fjMN0VuqfNhhOccxzRCpY=;
        b=DQzYttVegAABDfpk+MosZHl6kCHZWRPYli4H4YEG0dWqp9uHMseMn287MT4g0G8cmT
         aZDIaqmkSi8pttYmOoz7VzbRsfjK8wqjRhHrEKpXbRk5yW4gpdIaxS6vPFuZcN6cxTNg
         8KeahDmoef1Og0esEuHr0a8F5FtSx5eV6L27KJYY1kQvZRMFtEhx4BOC4wBvBSDMZb1d
         PzJvzCRolMZQVhTW4w6OK34pzVWeYy5foOl41X+qMs+qbL5uzWgvSH8doUiDfAbvjUa+
         5BMG/yIJw0x8pEUWpOEoZqYgJXbDT8LdhSmlI/oEIHuOt0+dTGN9/e7PEGFXxHP4AOiO
         ZDaA==
X-Forwarded-Encrypted: i=1; AHgh+RpClrFL1J+GWbdDrdRb2YXwLQNvPBLdTpnufO8Hdxqn/rh16Uj3Gyp9uJT28n0ESBoOVYA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6GptKmVENPwaPzFIVF8wj+8zGIQ2rGTmgZMxzVkP92hxHY70f
	Rlo97azhrSzFvcJzkxO3U1r0+6+IgbRssi94WiIQ600iUt2D6P4vrZVE
X-Gm-Gg: AR+sD12r211ItlTSHb4NAhf2YcNIZbUW8GAWdbYXqfNjoYbjxcJilOPGfZ7D8xK2VTU
	g/RZEs0e9B3vastE3DU97B/kcY4kRLuhiv91ee3wApMgsnnd++1IoHb5KVKTw02yWQO9695QPGZ
	ap6MZ0UMA4HGoGpvED5/r+kzsHdzVqSlDbkZ0ZW11FP8L4NF9AQ9cROXiW2yb+sm4pmNMZothMl
	CoPfvVcR2a8+8sidKtK9ckRyDK8CZ3a4uTVHJWkeBxq8UELegZ1uYfgNEMl7wdeLGiHOxURnWw8
	fxGv4WQLOjrXrwEaAnEBMAi5MsUwNaS6lD2uJSsv5ukk04oescdoWumOSTMz14Banyq7mn3F850
	8mL/5q3S0HMcaQ/aWXnRP3+8Fv87FWxLVhq6ShIxAAsiYnKFmT23aQoQ2STxzsq5efLqgFrc5/C
	tcsV6WmYapyndoQC9UKbDpMswGJGD7MEfcpWNyv7dq+3e8GWQ7GcoOidNuckI1e0F+7gRw67/YS
	hs3FWHxgfXCY59EA4r6YbxAoJttMhhV3xdS0T88g0Qor+FaZ+BNuFdGeH/4zbk=
X-Received: by 2002:a17:902:d547:b0:2c9:df1b:e948 with SMTP id d9443c01a7336-2d3b0cdbdcbmr380270855ad.4.1787033500995;
        Mon, 17 Aug 2026 23:11:40 -0700 (PDT)
Received: from secrnd-cstp.tailb7f510.ts.net ([125.131.91.97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d5c1e54359sm10412685ad.49.2026.08.17.23.11.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 23:11:40 -0700 (PDT)
From: Sanghyun Park <sanghyun.park.cnu@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	bpf@vger.kernel.org
Cc: Sanghyun Park <sanghyun.park.cnu@gmail.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Pu Lehui <pulehui@huawei.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v2] bpf: Fix stack out-of-bounds write in cgroup link update
Date: Tue, 18 Aug 2026 15:10:21 +0900
Message-ID: <20260818061021.2551771-2-sanghyun.park.cnu@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The cgroup link update path checks only the program type. Several cgroup
hooks share a type while using different runtime contexts or verifier
contracts. A UDP6 sock_addr program can therefore replace a UDP4 program
and write beyond the four-byte ipc.addr context into adjacent fields of
the stack-local struct ipcm_cookie. The same omission lets an LSM_MAC
program replace an LSM_CGROUP program despite the incompatible return
semantics.

Validate replacement programs against the link attach type. Use the
existing per-type rules where applicable, and compare LSM
expected_attach_type explicitly because both flavors share
BPF_PROG_TYPE_LSM. Preserve legacy non-enforcing CGROUP_SKB
ingress/egress updates.

CGROUP_SKB programs do not require CAP_NET_ADMIN when loaded. That
permission is checked when the program is attached. Once the link exists,
updates are controlled through its FD, so BPF_LINK_UPDATE does not check
CAP_NET_ADMIN again. Keep this behavior and only validate the attach type
during link update.

Fixes: 0c991ebc8c69 ("bpf: Implement bpf_prog replacement for an active bpf_cgroup_link")
Signed-off-by: Sanghyun Park <sanghyun.park.cnu@gmail.com>
---
v2:
  - Extend validation from cgroup sock_addr programs to all cgroup program
    types, including exact LSM attach flavors.
  - Preserve legacy CGROUP_SKB ingress/egress replacement compatibility.
  - Keep the CGROUP_SKB CAP_NET_ADMIN check on attach, not link update.
v1: https://lore.kernel.org/r/20260805052858.2390918-3-sanghyun.park.cnu@gmail.com
---
 kernel/bpf/syscall.c | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 8d111da886553c..de7a8b46814648 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -4462,7 +4462,8 @@ attach_type_to_prog_type(enum bpf_attach_type attach_type)
 }
 
 static int bpf_prog_attach_check_attach_type(const struct bpf_prog *prog,
-					     enum bpf_attach_type attach_type)
+					     enum bpf_attach_type attach_type,
+					     bool check_cap_net_admin)
 {
 	enum bpf_prog_type ptype;
 
@@ -4473,7 +4474,8 @@ static int bpf_prog_attach_check_attach_type(const struct bpf_prog *prog,
 	case BPF_PROG_TYPE_SK_LOOKUP:
 		return attach_type == prog->expected_attach_type ? 0 : -EINVAL;
 	case BPF_PROG_TYPE_CGROUP_SKB:
-		if (!bpf_token_capable(prog->aux->token, CAP_NET_ADMIN))
+		if (check_cap_net_admin &&
+		    !bpf_token_capable(prog->aux->token, CAP_NET_ADMIN))
 			/* cg-skb progs can be loaded by unpriv user.
 			 * check permissions at attach time.
 			 */
@@ -4596,7 +4598,7 @@ static int bpf_prog_attach(const union bpf_attr *attr)
 	if (IS_ERR(prog))
 		return PTR_ERR(prog);
 
-	if (bpf_prog_attach_check_attach_type(prog, attr->attach_type)) {
+	if (bpf_prog_attach_check_attach_type(prog, attr->attach_type, true)) {
 		bpf_prog_put(prog);
 		return -EINVAL;
 	}
@@ -5797,7 +5799,8 @@ static int link_create(union bpf_attr *attr, bpfptr_t uattr)
 		return PTR_ERR(prog);
 
 	ret = bpf_prog_attach_check_attach_type(prog,
-						attr->link_create.attach_type);
+						attr->link_create.attach_type,
+						true);
 	if (ret)
 		goto out;
 
@@ -5922,6 +5925,7 @@ static int link_update(union bpf_attr *attr)
 {
 	struct bpf_prog *old_prog = NULL, *new_prog;
 	struct bpf_link *link;
+	enum bpf_attach_type atype;
 	u32 flags;
 	int ret;
 
@@ -5959,6 +5963,22 @@ static int link_update(union bpf_attr *attr)
 		goto out_put_progs;
 	}
 
+	if (link->type == BPF_LINK_TYPE_CGROUP) {
+		atype = link->attach_type;
+		/*
+		 * BPF_LSM_MAC and BPF_LSM_CGROUP share BPF_PROG_TYPE_LSM, so
+		 * the helper's default prog-type check cannot distinguish them.
+		 */
+		if (new_prog->type == BPF_PROG_TYPE_LSM &&
+		    new_prog->expected_attach_type != atype)
+			ret = -EINVAL;
+		else
+			ret = bpf_prog_attach_check_attach_type(new_prog, atype,
+								false);
+		if (ret)
+			goto out_put_progs;
+	}
+
 	if (link->ops->update_prog)
 		ret = link->ops->update_prog(link, new_prog, old_prog);
 	else
