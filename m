Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794415698;
	b=RoAi/bwpdpqimpz26zB1FY4X1s2xXC4u0dAfB2ItWsApykh4lenGDiNwaIml/na4olL5
	 XfVF8hdoVKKzo0f8dSRgzoCt61ykdQqprpFFvpre2h+AXitMf++JgB5EO6zBP/qBBkVbQ
	 jaXcTSK1C5YmCcJJ6WU59YqKGvhD0OGkJJ+/DPqqNnvjXRiiUmtNXgSc3M/a9J77QwFH2
	 hWIxpsIrJTBFUG4NLYXIGe0ZjyogRP9XmjzQjJ6cAU9VitDshqSjIfC23L5rI9snyMvg8
	 VHhyhs2tDHcK5Ziw4//Y96UCA+gDB2cVYowX+fBilMjOrBhms7zymrDjrmrX8yBJRVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794415698;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=zmvsoqg0UvyFkmW741QEMpZ+DDOrvdomqQq9bMxi3nA=;
	b=UukLCOmDus/5E3y+1L/6gNjiskBAcoeAy0u7TNc7/LeVh6gjPz/bZ2M+MTEm9h3IReHT
	 Nk4chbZuFfTi10bovJkOdPvX54pc9mHZFlCzD2HDr71gw3LaUmpPa7Oes620oxQVtc/5r
	 HXkMs6UEds89059rjtxK6OSanwODErS8p1yGH8B5DBRL755dSdcx/0gIp928UgK/Ixbje
	 5fsKopYWRnsKq8WEGLq0dDR3lyceGOKVG+YplUA3RwagMPSSkyife4PVocBCPmycZo+0a
	 PWeqEQjI7gME6CYBeddorSZewJ9xhZVOMkJBfVwXnvtsayU7lkDvuG+B//ZGxCdh2Aw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YM4Cj4Yi;
	arc=none smtp.remote-ip=209.85.215.174
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56397606A31C
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 16:48:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 56397606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YM4Cj4Yi
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-cdd89d84521so5021a12.1
        for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 08:48:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794415698; x=1795020498; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zmvsoqg0UvyFkmW741QEMpZ+DDOrvdomqQq9bMxi3nA=;
        b=YM4Cj4YivySKpnlbn7ZeJ8lPNiDL+bcOYBRZ82cHrWnEp/xbINA4dSk7f62Fczq6sU
         0pL5t1yveqpQ2K3QNZcmRxRYqIbTmA1G2FqfPJUMZxcIzYsl8++L6xiPouIflmHIqntJ
         vDFMGrdo7XTFyWJl6TwxhWYM8jx65303o/kgigJB8dJKghbEo8BuAwdTsHbDvK9+LPUN
         xuobQ3v8Fh+exuXNfOgj8ngM9lPg0NPrUMPCwOFxs7439h0undj1kBkJSZZ9IMQvkU+0
         eKTgR6U8ipIGH751IhMNzkRtUtH/rN2pggt/KfPkCSejU/owh2iTBoJoPhYqDQsrE5AI
         8pXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794415698; x=1795020498;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zmvsoqg0UvyFkmW741QEMpZ+DDOrvdomqQq9bMxi3nA=;
        b=iWVc6U/+xgXhFId5dawkDTGyzV0jyw8RCSacl5SnhE+PfXxVsdOxtWA9LE2o7+y9dp
         jO8JLso34LQnUYIjgac/Ebs7+ETBFrsvq46b4r/0IADmUUqfvyomHdIt0QxJh07oD7gU
         Yop9YrSAcrBizIjOyyiMVZskPjprW/nelRs7VFh1jC+FY827Umhkn8J83A+al9hvDI+n
         tRfeGoMweiU752r8Ja5259PwlFYCJvckjlnjVLhfld0DsCEm2+r+8hCWekQswSeBC72Q
         52YYQtxFXArvkqR5KBgsixXaSM9DNoXsS7pXwJ3FrNr+ZGmji5ZRV13rQzA4bg2gRwil
         6KlQ==
X-Gm-Message-State: APuU4Z96cttYUkvQi110UHQoGBWvmUUirfSmE74RT28jJ8pwZoipfuXm
	OLxm7hIOgWLttwAene4Tf2hNDvUmhEg2aVj0f5QkL6pFUhyKVvN6LXg3eRgjpw==
X-Gm-Gg: AYBFou2F1/6nKgepGRnvD/ZbXEsDVyKmTOE7Lx50XVxcHtDLp9CtckzwEApitW+TMbG
	51bgpHIJ+hkT93SeiAREiC369FEsrTLnzIxy7ZQXHxOuMFDMjx6JF4FtGynocMvD3rGiTV/HIiZ
	vdr1OEyizc2sObE5NS2IjvuxIqRx9imfGa3cAXT9CyxIBQ76N8TG8AuwEoKJG8F//GisN3Gya2B
	OSPFFOq2CbtoSqA/dUAkLdnO0hqYB6wuBUDPXKDFZppc1VYe1k2wIr/b1+qqEsi9198gpHYrLeO
	HgtH3YilV4PhD/WhsfLqrKWYvTApzzpmP6qg4eZU+JveMRzlcwYnOUiQtrstAcZv/SyyGq9UH1U
	O5pMvxyHgiAXBhXQdFkg8l9Jc3m603by3gIPd7kqNogVU31QPT3ARaPEVVM9jAc9I0/AgCuWbZk
	uYOReG5EY7tCiCKIrkzpLtiTU6ZmWHVuSntn3ANnJ1ZvSfJqqROKdeS8q2PHzamk5T92IKIb9jK
	y8c/qt6ruePsX3dlMUHM8zkD6PcNFw9g2uM4/pszXScku9vgegqXQcsPwYIySOGHm2/y+pnjCXs
	quzRXTGptYU5sS/SXeN8vgaKPapGZAAVLc69D2IxTG/sZQxD8UuXTbVIwdGPN3/PhpARcQaPXc/
	pRgFQS7rc6EAKIc/8WiVpSb3ysUAWcY1O1LFmY3e+GlnUHdJ/toESK2TrLlj1C6v4lrmJIXq8fQ
	==
X-Received: by 2002:a17:90b:1d45:b0:3a0:cca0:4a8c with SMTP id 98e67ed59e1d1-3b197c817dbmr44226a91.7.1794415697676;
        Wed, 11 Nov 2026 08:48:17 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.252])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b197c42c68sm80307a91.3.2026.11.11.08.48.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 08:48:17 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v3 23/29] bpf: Recognize copies of a scalar by their ranges in flow_join_makes_up()
Date: Wed, 11 Nov 2026 16:45:46 +0000
Message-ID: <20261111164557.2659679-24-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261111164557.2659679-1-alexei.starovoitov@gmail.com>
References: <20261111164557.2659679-1-alexei.starovoitov@gmail.com>
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

A prerequisite of the removal of scalar ids. flow_join_makes_up() is the
last code that learns something about the prog from them: which registers
and stack slots hold copies of a scalar. Recognize the copies by their
ranges. The function is a heuristic that decides which states are joined.
So this patch is about the number of states. Soundness does not depend on
it.

	err = update(); ret = err < 0 ? DROP : 0;
	..
	if (err < 0) goto out;
	..
	if (ret < 0) ..

The states (err >= 0, ret = 0) and (err < 0, ret = DROP) get to a join
point before the jumps. Their join loses the correlation of err and ret:
it has err < 0 with ret = 0. So two states stay apart if two scalars that
later jumps test each have disjoint ranges in the two states, as err and
ret do. Copies of a scalar are treated as one scalar there. A jump that
tests one of them refines the others, so their join makes up nothing, and
compilers keep a value in a register and in stack slots at the same time.
Copies are recognized by their id, in one of the two states:

	if (one && (!id || id != (ra->id & ~BPF_ADD_CONST)))
		return true;

If every copy is a scalar of its own, too many states stay apart. The
init prog of a sched_ext scheduler in Rust goes from 36 to 512 states at
one insn and takes twice as long to load. At 512 flow_has_room() is false,
and states are joined by force.

Copies have the same range and tnum, in each of the two states. Treat
scalars with that property as copies. Two scalars that are not copies can
have it too. Then two states are joined that stayed apart.

veristat over the selftests, Cilium, sched_ext, katran, bpfjailer and
programs in Rust: no verdict changes, 199 of 32913 progs move, by 0.01 % of
the insns in all. The scheduler stays at 36 states.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/flow.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/kernel/bpf/flow.c b/kernel/bpf/flow.c
index c9458b3ad114..778288acb5ba 100644
--- a/kernel/bpf/flow.c
+++ b/kernel/bpf/flow.c
@@ -2603,10 +2603,9 @@ static bool flow_join_makes_up(const struct bpf_flow *flow, struct bpf_verifier_
 			       struct bpf_verifier_state *b)
 {
 	struct bpf_func_state *fa = a->frame[a->curframe], *fb = b->frame[b->curframe];
-	const struct bpf_reg_state *ra, *rb;
+	const struct bpf_reg_state *ra, *rb, *one_a = NULL, *one_b = NULL;
 	const struct flow_need *tested = flow->need[FLOW_NEED_JUMP], *need;
-	u32 fr, i, id = 0;
-	bool one = false;
+	u32 fr, i, len = offsetof(struct bpf_reg_state, id);
 
 	if (!tested)
 		return false;
@@ -2623,11 +2622,11 @@ static bool flow_join_makes_up(const struct bpf_flow *flow, struct bpf_verifier_
 				continue;
 			if (flow_gap(ra, rb))
 				return true;
-			/* copies of a number are one number */
-			if (one && (!id || id != (ra->id & ~BPF_ADD_CONST)))
+			/* copies of a scalar count once: same range and tnum in each state */
+			if (one_a && (memcmp(ra, one_a, len) || memcmp(rb, one_b, len)))
 				return true;
-			one = true;
-			id = ra->id & ~BPF_ADD_CONST;
+			one_a = ra;
+			one_b = rb;
 		}
 	}
 	if (!flow_needed_consts_differ(flow, FLOW_NEED_FLAG, a, b))
-- 
2.55.0

