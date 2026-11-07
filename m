Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794071003;
	b=rdbF7i5JOUfqa3xd1HgHhY/MQWQW8QzghQN8Bf1WWqiCjUKU/mU+zPAJ2yfg/4IKQRE6
	 VF8eMpUTvDdhueJH0IiiBWH3TPPC1S/MDxaj0d+DUWTF1/N/8wQWdaQpejNuy0B61F9yT
	 roGE9XgOU/frHyYLnS7dnYmUHYis/LnAyHXFfcdO4Q7vFCLrGnjJk4Lp77wkYs3hfthM2
	 AAfS4U1PnnWwovnnNYVRaZOpknJsLXhMoKAA3BxzPRP9oQoDBVn/uT+UElRoHCQ7zoXcI
	 ccdDwKedEN5KuM7DxPT5UyQGqel+bKlbTOGg+SElQFR84Yusm18a0YreocHLcfLF9zw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794071003;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Dgy57A+ykqvklf6t9ZJQ83dCSHOT7MP3eEX1mnAE9/w=;
	b=EzFMH1YaYjraERrL0r21Ior/hWMa+fT1Ado/bNhjpku9LYd1UuPi0uHBA69NZQUO6Gt/
	 vyK1Q6dlGH1dr/yg/X4VPmBqp6lYpAMjtTVFBEFWfTinWdlmjhTFFjRywYsAZWAOUgJDX
	 496baljHQA3Cepkcaker7nJX3cEngvIVx8us4WlC0b665lDy87F5uv1fYNps5S7Me/Zid
	 ySWbg4jF1eJ6QITDJ5q/Oy6F/0L/qiDMQSqlmlUX4Wd1SLbTHzw/47loI6PFEuecMyTFh
	 OUbzJi91bX0QVKE9U1IJRySnUSc3mrWVElnQfY3HEUHEjpCP3eADbtubOYwU/0GKNVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Xu00u8yx;
	arc=none smtp.remote-ip=209.85.216.47
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46574606A32C
	for <bpf@vger.kernel.org>; Sat,  7 Nov 2026 17:03:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 46574606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Xu00u8yx
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3b0a2a44a0cso1238013a91.1
        for <bpf@vger.kernel.org>; Sat, 07 Nov 2026 09:03:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794071002; x=1794675802; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Dgy57A+ykqvklf6t9ZJQ83dCSHOT7MP3eEX1mnAE9/w=;
        b=Xu00u8yxdYXMKFd5KgisrlnDZ9zgNPGhP8y9hoY8EWhys+nmY+ELwXq10Vd1+Bd6FR
         iEVws7XpQanVAqt4gn3RWDz7vKerrizWfEnFIVlgz186cCFu6guGZcIAJnWzP2dOEJTO
         /j1bkf/I80L8Bfj8n9wG4+9MNbkguWV9NeTmg4O6Iua6MRgRwW1sG4z6zn5QHiSTl3G5
         tUm+K9O7f2llRVhcpvr1DscvS94/BDAGVvSUE9tIzAgoYqwUxCd5qlHJZ4heI8WhVlaa
         iCsrnht5x1d8Ybm3ipEtyocDl5kxpplzFQ85iDChsTbtLv2gAiF+GND/E4HGAOcTD0xB
         aKaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794071002; x=1794675802;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Dgy57A+ykqvklf6t9ZJQ83dCSHOT7MP3eEX1mnAE9/w=;
        b=d3o4OfmgJ/sDIdWEYwkrj0/qymraJfpULouFGR/1CJywgFpVkYH/r3VvKDGievNVJ0
         6sfzXl6nPJLByiWGmZgBF209wuAQMUHH74OcG59bmj8REFNIWaE7GQGLsEuX0xG1BOU/
         EY3dCYHy7mXVoXIWZ/f+yUjaetgkMhsgof8MUKEl8txnLKyrMW3Uh+yYEzuyIXFucF8j
         1z5MBRlwVZvl5flHc9NuWJBtvEoQQyZBIikWLYXWO4ZgZ82xuyrwha9C+tZ35ETw1S8D
         TLGLU77wZG+kUU8d5nKYsMC2dyQFqZLlScoGWE+isJRMorRqsEs7mLl1qAxBu8EKtuhR
         ciug==
X-Gm-Message-State: APuU4Z8IWcXQ0hUIUtdjzRur57l7POljlQkQb5EcaQIgLC0IT5AE24qv
	biOTQahPPmt+4XJ8HK8McD/3+hT/eI5JRqZoBpU7jurmlM3T+sY2nXUDFdUzIg==
X-Gm-Gg: AYBFou09psc9aIOMToR4Aac5tkUFMce0mAiQ5gGL/cdozvu7Y01PZWAES4WAdGE4ag0
	QMt+6cuGD71BlARkbPPRmDKGnYlWoh41gC2CBIe0Zsj5W87EvaCit1Zcj6W38/+VOb3cXu7qbIP
	CXpGsRlPWYUGxTQprooZ9z9uaDuGv7yV93vjhHpbWkgqOvsXuL+7HH4VI+Yobm85HXDKXg4wiZQ
	VekY7nMkIAKlRli24/OW0XeL9KZHO2Hw1QQ5OtU97wvNxy00FFHc1R6PmoEF6M/8eKuMfEmNLcR
	vDjVG6owXC6i1k17nX6EIJAq25v2pzpqaGUBLMOKLuJ+L8qqEs3SeEXNvCYrdrp54EejtPhZkA4
	hQpczVENikM6zMZK+7UdImTTfRQA3ZCdxx8ft2lq1B/B3tPDGxy1XfebLwRnUYDTiUzMlaj/4kG
	i0FKHMTcbb749jgZ8nE834G6y14fow1PQ4IAk8U30xfZKLChP2u/4AowQHlANjKD3Q9QUS7Nfre
	SILqf/AuCSJkSxObqA9+je6+SUjyTVBL2A/ClUxVzMdydlZ1VfzmAA4jOfZIDNbOVc8fvhYJ7hR
	9RtqSUFr8j5g5C8xpBquM665JTBSD/yo7ECnXyKHb2izAXQWSgtlK1KbBSC/Ez7yGm7h75eIUtM
	f2TqIGSuD3WHLBmkkpv0LI9eXTxwj1DETxqWDm63iHk5SUFJB4iIsHvnQJp1g1+et3e6Elv8Sjw
	==
X-Received: by 2002:a17:90b:33ce:b0:3ab:7031:d962 with SMTP id 98e67ed59e1d1-3b0db70e4femr5439328a91.41.1794071002394;
        Sat, 07 Nov 2026 09:03:22 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.248])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b10583c8b5sm4178611a91.12.2026.11.07.09.03.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 09:03:18 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 1/9] bpf: Leave a number alone that wraps in front of the jump that counts
Date: Sat,  7 Nov 2026 17:02:58 +0000
Message-ID: <20261107170306.2831028-2-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261107170306.2831028-1-alexei.starovoitov@gmail.com>
References: <20261107170306.2831028-1-alexei.starovoitov@gmail.com>
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

From: Alexei Starovoitov <ast@kernel.org>

	for (i = 0, n = first; ; i++, n -= 97) {
		n += 100;
		if (i == 2)
			break;
		use(n);
	}

n is linear at the jump that counts: 'first + 100 + 3 * k'. Behind the jump
bpf_clamp_scev_regs() gives it the range of one iteration less. When first
is a constant it gets the step 3 and the residue '(first + 100) mod 3' too.
When first + 100 goes over S64_MAX the signed value is 2^64 less. 2^64 is
not a multiple of 3, so the residue is another one. reg_bounds_sync()
rounds the range to numbers that n never is and drops the numbers that it
is. What takes n as an index is checked for the wrong numbers.

scalar_step_add() drops the step of a sum that can wrap. Set no range at
all in this case. The register keeps what the state has. That went through
scalar_step_add(), and it has the low bits of n, which bpf_set_reg_range()
forgets.

'bounds.base + moved' can overflow s64 when n itself doesn't wrap. Add the
residues, as scalar_step_add() does.

Fixes: a00c8eafb381 ("bpf: A loop is one iteration shorter behind the jump that counts it")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/scev.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/scev.c b/kernel/bpf/scev.c
index 5415fcf9df2f..6a9d16ab37f3 100644
--- a/kernel/bpf/scev.c
+++ b/kernel/bpf/scev.c
@@ -3992,7 +3992,7 @@ int bpf_clamp_scev_regs(struct bpf_verifier_env *env, struct bpf_func_state *cur
 	struct env *header_env;
 	struct bounds bounds;
 	u32 r, r_scev;
-	s64 moved;
+	s64 moved, sum;
 	int err;
 
 	if (entry_state->curframe != cur_func_state->frameno) {
@@ -4044,8 +4044,12 @@ int bpf_clamp_scev_regs(struct bpf_verifier_env *env, struct bpf_func_state *cur
 		if (coefs.base_reg == entry->iv_reg && !moved)
 			iv_bounds(&bounds, entry->iv_range);
 		if (moved) {
+			/* a sum that can wrap has another residue, see scalar_step_add() */
+			if (check_add_overflow(cnum64_smin(bounds.r64), moved, &sum) ||
+			    check_add_overflow(cnum64_smax(bounds.r64), moved, &sum))
+				continue;
 			bounds.r64 = cnum64_add(bounds.r64, cnum64_from_srange(moved, moved));
-			bounds.base = imod(bounds.base + moved, bounds.step);
+			bounds.base = (bounds.base + imod(moved, bounds.step)) % bounds.step;
 		}
 		if (behind) {
 			/* jumps on the way may have told more */
