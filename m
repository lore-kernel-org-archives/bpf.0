Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44FEB3A6EE6;
	Wed, 17 Jun 2026 19:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781726143; cv=none; b=G+YG6JY2SgAfoq3WVASPByRiBxfrIiFiCxOB93A3k/UWaAWUZCzcaHvDh1Uc6oOdC3QxprBaizGRtHiumeQpg9ppfXUNXnQpAYP+uCIa9B+ZCfzAfo5VoGu5mow5FMpmiKgkO21Hb12LeWiSVnWWjtyo+iQz0N4fQ7Z8tNQVTwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781726143; c=relaxed/simple;
	bh=V18gbj1vJ8IADP15mWwGpVseCsp9pW46uoIX03YcBmY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hkwi4gm4jR3Z/tgfE3j7gfkrLC2nsWL9HkFHRrenw8Mf0hjVlYfB2lCx52mMn9o5lncsotOWf2fU/zEF7rLG6JQukoo3bNqvf90uFabUphPGQPf7rbMNMA11OkC75mGfYFFGEtKVPUVmpNTRuU7hdcZDaKuCU01zHHfocT3QHJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=k5S5n+RK; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="k5S5n+RK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1781726120; x=1782330920; i=markus.elfring@web.de;
	bh=Zkjxiv2OzXXACBMnS6hNYV6PrCKFy5WJIpmTTALkucM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=k5S5n+RKbChC+SZgpBnonckUWpaK6sLn176SJJlv6+W5pHBIBgqY/fLSG5JVo91M
	 srNYo7zAGiDwdlrYKsJ9Pzr0s+qAg5m3D4qoQtL2AeP/o0K0MN457iclZHBPHmwY6
	 Vg4cXn3YWUda1djy9AzGNSxvcMTSNdW1Qlp1yn7LWVuOrkA5VpBpbR6qYc9flvDge
	 OelRR6LFD+Zh5HavyMrfe1fWl8jAQSZ7L8sLfhRozW/r6hY377P04ANzbLMWnQJ+J
	 X/CEbw8l53JL7GsPh0w0uZT5QJ2RIvVrP/Tw2dPaFioiywJhLROEtRR2Q+hM0L/ri
	 wm5KS50Ha9Z/I7YwUA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MuFD7-1xU6FB2aQ1-012fKl; Wed, 17
 Jun 2026 21:55:20 +0200
Message-ID: <451a504c-d7c5-4cbd-9184-25156f2fc581@web.de>
Date: Wed, 17 Jun 2026 21:55:18 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH RESEND bpf-next] bpf: Use common error handling code in
 bpf_is_state_visited()
To: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Eduard Zingerman <eddyz87@gmail.com>, Emil Tsalapatis
 <emil@etsalapatis.com>, Jiri Olsa <jolsa@kernel.org>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <d6622225-c765-4d9f-9501-1021df4687a4@web.de>
 <DJBL1JEE322B.28EZ7GUNTJP99@etsalapatis.com>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <DJBL1JEE322B.28EZ7GUNTJP99@etsalapatis.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0dtuQgJKPanhFqqtyxi47x5SCHNlC/aIemJw36MUxtysUxMfixs
 Ocgk8bTzdXwQlZTrcQhxo6l0VCD+lZehMD4dpLOGXVIp6zWcwCB9+eaH7tALbkZHe1U0vZ7
 S9V0UEbWTWGH8LCnDx6PXGXkuM+RSL86IXndebm9XVdz8em0ybxvbj5Vuwkmi3NtDaC3OIr
 /xrsQQPjESDuxOKgLbc5g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:+gip8uKE6CA=;twtr+FjZ+Sl4w/iNO73TcRSFe2q
 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
 XvksHa3hm+FIecdp5dyge/RtbsUZsSlcrKiZZzR

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 17 Jun 2026 21:15:08 +0200

Use an additional label so that a bit of exception handling can be better
reused at the end of this function implementation.

This issue was detected by using the Coccinelle software.

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 kernel/bpf/states.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
index 5945956a7573..09f87e2bb1e6 100644
=2D-- a/kernel/bpf/states.c
+++ b/kernel/bpf/states.c
@@ -1566,21 +1566,16 @@ int bpf_is_state_visited(struct bpf_verifier_env *=
env, int insn_idx)
 	/* add new state to the head of linked list */
 	new =3D &new_sl->state;
 	err =3D bpf_copy_verifier_state(new, cur);
-	if (err) {
-		bpf_free_verifier_state(new, false);
-		kfree(new_sl);
-		return err;
-	}
+	if (err)
+		goto free_verifier_state;
+
 	new->insn_idx =3D insn_idx;
 	verifier_bug_if(new->branches !=3D 1, env,
 			"%s:branches_to_explore=3D%d insn %d",
 			__func__, new->branches, insn_idx);
 	err =3D maybe_enter_scc(env, new);
-	if (err) {
-		bpf_free_verifier_state(new, false);
-		kfree(new_sl);
-		return err;
-	}
+	if (err)
+		goto free_verifier_state;
=20
 	cur->parent =3D new;
 	cur->first_insn_idx =3D insn_idx;
@@ -1588,4 +1583,9 @@ int bpf_is_state_visited(struct bpf_verifier_env *en=
v, int insn_idx)
 	bpf_clear_jmp_history(cur);
 	list_add(&new_sl->node, head);
 	return 0;
+
+free_verifier_state:
+	bpf_free_verifier_state(new, false);
+	kfree(new_sl);
+	return err;
 }
=2D-=20
2.54.0

