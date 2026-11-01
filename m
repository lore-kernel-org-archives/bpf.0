Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793560016;
	b=jgblSI8Qi6pFxyH7D1yQ3OOBGxiQsiMbZL0mKc4Ewq6vefeuT+uZENfS1RMS0yorctbR
	 vAxBnuHP+w76H83Sd7Pee60Qe2gKDztoOqVfLsO3BL6bw3zL7+0OcOKi6reKtK0o0c7Hc
	 W1exw/1gNSvtmc2F4Quw/E6FOmwKEmLy9ZlN4fgfVvI4zOlmyC/s3iVppPCatSr5yElUT
	 cn9NKOjxBLrTBwZYnDxQJpZxbzbHqHSg7NaI+6oh/AvtFMyyplciGtqInSuF01SfkfPII
	 TONCG0vvoaxfpsW6/qkdwzt5dSQGK/g2OUf0/VCWo+MH2M8ZgauF/HrT6q1BeYmUBvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793560016;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=d4pbkTqS8rd8iJLTsXjJradA2PUz9xr2RYOUf6mVjws=;
	b=tdfGxgzW/CirTaIAJpmQPE3UNXVDHZvjWDsd8xM6ZREKxUoVMZaaP4luufuIK0+jELxR
	 dCDZasbLF7Zw9llcroiA8uUujkBgX5AtMZDSil/aaLMy6ngIdMcyx0lcwPEvwhop39zwF
	 XzX5oyjFzPcoLN8SVYzGTBAQb52Awej+7ZLNq1mUgN6cha8sqDNKESCNqpIyLmfu9u0Da
	 OjnrE2v2ytTnwVwJ+jpEsrMFcFes2UPRqHyXbCSZyqWKXgcb7OoI3G+foBzC3TkjTong5
	 0Q8IljQShSAvXPMgcepgF6ryUzfCvBvJpay8IIAP/uBKqmq6aAcchRie2MtUaDIRYCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=H54P50jr;
	arc=none smtp.remote-ip=209.85.214.175
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 591F4606A325
	for <bpf@vger.kernel.org>; Sun,  1 Nov 2026 19:06:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 591F4606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=H54P50jr
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2e8fe8e343fso14969915ad.2
        for <bpf@vger.kernel.org>; Sun, 01 Nov 2026 11:06:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793560016; x=1794164816; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=d4pbkTqS8rd8iJLTsXjJradA2PUz9xr2RYOUf6mVjws=;
        b=H54P50jr0gqpxt0fAAVcB3ouQJisQK/vMQm3WiHcQGwrO4S5XEtGS/4Xwll/9tvUSW
         bno6bgUNQYiCdnCZTUoM6ERb5+JlvF9Q7arTJp75CEHSmbrUqYJkJQhQA+dN5c/E9hi+
         ifuHIw+m/6NTGEweH1NptBIVxYaYRNesEhIHrRVCtYFf/seGMJUUTqRoFWgIGx28bJz4
         9+UziIMQYFsUkzwmnCD3PdKgphq4HdZCnMUsikqmAmQBqe2LSQDqmu1SpDjLgDYEtuNK
         +2wDHxXQ87rtMgLL+XpFqcW9Si9eQ7fBPu9UiZt20Tjuwdj6xoR+aDo/ewKqPsLzXbVx
         IwjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793560016; x=1794164816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=d4pbkTqS8rd8iJLTsXjJradA2PUz9xr2RYOUf6mVjws=;
        b=KXd0kmAS1ogq1TCEjWigaEaPYAhWNM6Y30yhmQGyo/VgBpauXKNbrSu+tA0dvHjgSn
         v26PuYqTGtoc+xdX8YZYf8gJrVRb/GxjGthlZfA0ltB56UMCZ0rr+JiAINbBHoyY6fH+
         FqN79gsq0sXogGwSIsmCROoYeZMnmA7LIZNtlX1DjnjzaN5rEuG/Hv80CIsuUpMDWTiV
         W26mDHB/t3UgyoMkbXzCMkop4Aa5Y0uD3hYIh5+Y/gpQxhLB/GT74eYfzO5gW8VU2woq
         HvHdiK3EwYJi2NiMuAYeW64Ld1ixc7qwGtyYFjwzeas7hN+GAOd7VlcPbwq2/LUBrfpa
         1+GQ==
X-Gm-Message-State: APuU4Z+lLU5DAKoOS+iIejVBHP9Xn6zdNuI3RzpKNnY9RDsOgSvtVD8s
	r6wmPqrJydQs4SAVlbZB+xn7CAcLYa09w4I0lmifzkK61OQVmzHzZegcSvl4qQ==
X-Gm-Gg: AYBFou34jsaDZdZeF3PCh8sfUwJYo+nN1ZgE2v9rzShyGevXof2HALVkIskdbAq3mjf
	dWtNc4q7fFloWvvMH0sdNBBayNURqxFbC+Go5tc2KMo7vcr+Ps1AV4ZkcpYZ2zPeWgZC0TOFHZw
	/0T0JvqSsuYaBNzeu0/LONfmnHFnIhpOWzZQ8efudi8XRTc6B36XyuKwLNdFN0fwtzcnWslMtH6
	edZmcrXTgXy9g030q19UNNNBKMMHlWFCULGdyvHLYG5G7wFgbk/MtrVg1xPw1IFwAAQlmvON6Jc
	1i8oA0kW8iyVigZAcZn+IkS34Jwz/MmYFE/0SiHRbS1uR7yR/91GIBVG87aCMGcVCvktks1Geij
	zo0mr88ciyDkOxOSOZe/cUJcKHj6KO1FzXJC8p/xoqNxonOVW38WcaQyM/HHRM0ePOV4iEA6QJg
	884N1D2UUHZEpD1yfKP8iQrgJ4b4YFyJqyobAjYnLZX8o1gl86iweTMsBSNbunw7w60eBV0Ce3b
	iOi95bYOrgqjsLArvAsVEHqvVdln77p7VA6eyIZSsh3McIZscQwIlfOD+iE5QQp/Cx4G6vzGf0i
	ogQvLEdioiWkmwlr9I6Poquydaa3rJX3JK7dSm/jTi3t6IofR2NogiBFFnuldZC1IqGbPVbTi7Q
	HzFn3pqJlgNmBKUeJlV/+irvWWUipV7TOqym5jEMtu8qEg93f/h7fSGPCwCbHwWIrlFXhNtRlCQ
	==
X-Received: by 2002:a17:903:3904:b0:2e3:1d30:8658 with SMTP id d9443c01a7336-2eb36396775mr73203875ad.10.1793560015738;
        Sun, 01 Nov 2026 11:06:55 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eb39052bcbsm19290385ad.10.2026.11.01.11.06.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 11:06:55 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	josef@toxicpanda.com,
	mason@kernel.org
Subject: [PATCH bpf 13/27] bpf: Require prog fd or capability for cgroup detach
Date: Sun,  1 Nov 2026 19:05:21 +0000
Message-ID: <20261101190535.1454146-14-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261101190535.1454146-1-alexei.starovoitov@gmail.com>
References: <20261101190535.1454146-1-alexei.starovoitov@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chris Mason <mason@kernel.org>

Since the commit below a cgroup prog detach does not require CAP_NET_ADMIN.
The fd of the attached prog gives the permission instead. But the detach
requires this fd only with BPF_F_ALLOW_MULTI. Without this flag a cgroup
has only one prog per attach type. Then find_detach_entry() returns this
prog and does not compare it with the prog of the caller. Thus the kernel
detaches this prog for a caller with neither the fd nor a capability.

Compare the two progs. If they are different, require CAP_NET_ADMIN or
CAP_SYS_ADMIN in the initial user namespace. The error is -EPERM. A detach
from tcx or netkit without a prog fd already requires these capabilities.
With BPF_F_ALLOW_MULTI nothing changes.

Without these capabilities, a caller of bpf_prog_detach() of libbpf must
now use bpf_prog_detach2() with the fd of the attached prog.

Fixes: 2c78ee898d8f ("bpf: Implement CAP_BPF")
Signed-off-by: Chris Mason <mason@kernel.org>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/cgroup.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index ce82963bcfc7..ca681d626c9e 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -1279,9 +1279,14 @@ static struct bpf_prog_list *find_detach_entry(struct hlist_head *progs,
 			return ERR_PTR(-ENOENT);
 
 		/* to maintain backward compatibility NONE and OVERRIDE cgroups
-		 * allow detaching with invalid FD (prog==NULL) in legacy mode
+		 * allow detaching with invalid FD (prog==NULL) in legacy mode.
+		 * Without the FD of the attached program the caller needs
+		 * CAP_NET_ADMIN or CAP_SYS_ADMIN in the initial user namespace.
 		 */
-		return hlist_entry(progs->first, typeof(*pl), node);
+		pl = hlist_entry(progs->first, typeof(*pl), node);
+		if (pl->prog != prog && !bpf_net_capable())
+			return ERR_PTR(-EPERM);
+		return pl;
 	}
 
 	if (!prog && !link)
-- 
2.55.0

