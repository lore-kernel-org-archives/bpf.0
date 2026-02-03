Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6829A2EE608
	for <bpf@vger.kernel.org>; Tue,  3 Feb 2026 20:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770148966; cv=none; b=kUOgbftNB6b4quWQufsif+LcTfd/roPtstEImnKcr0+Db6+eGohonygKOHnWQ2z2yq/qUMv3nxYo1dY78H2FyVtNpFdFdZRscrH6Vm+GgB65QdWP3dXkfhZz/vR0Q+Dxp9m+DEQniSVN4hNW2NsBL5MRvbNhpQqk8Wt213Wlr+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770148966; c=relaxed/simple;
	bh=M02wuj7dQBeNDh5EnBEnzH9wOuvFcVq5LO80sKSrTIk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tkUKDDleZB3gvqDyUXTIsE5f2yfHI+HeVbQOOgr95Sc++fK3eUrmiBuI69/73iLHa8AkJDvzpQJVVuNNOR+wbOLVgAn8MgrJVTzgtMyTPbOcoh9MJ/KPmfT4kxZmtmkYy+PYtHt6VcnJGNnyS/LWDbDc4C385mAD31kEpc8aQog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=USF4va27; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="USF4va27"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2a377e15716so160315755ad.3
        for <bpf@vger.kernel.org>; Tue, 03 Feb 2026 12:02:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770148964; x=1770753764; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=58vpAXhIDs5lQirqOw7wql3Y51LdDMCZyU1M/Hgn72A=;
        b=USF4va27vFuU5gTD2E3+9XjcgZJNHEz3xPOnQEgHp9F+L+gt6Qa+fzSq9ewU1UyaF7
         h3EiLHWq110TT9QWohP1aUIIhp+YsU8SYa2Lk5CXI/3TOoxNHSclu5zqT3zIQuwkJgnN
         VTSqjl35zZw5gwmk/qeaZhtj30uggJc0ccTB2km7LyffBd79xx+4qTxy2Gbue7BF/gdx
         qN80uCrFmIr78MqfGVWQ57WV7z401S9iu8HFlA9OxrQLBfgd8HEu6DZ3B2ygO9FWQnLY
         qtv4kWjWiQlj/12arz4mWS12xjb8exbbz1EuWFMfUP8firxnh8s+r1HxA9P1ze29otBR
         sfCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770148964; x=1770753764;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=58vpAXhIDs5lQirqOw7wql3Y51LdDMCZyU1M/Hgn72A=;
        b=ojE7gh6wIxJtOfhXL8HoEG1B7Yn5yVFE4npwZRxxk36sBTiWHjvC921V0F4URBM35E
         UIIDF6l0dT3FCBWQM/UYeeYsEsL64vPaRcgRemUotdIAanzv6vmEKPLF33XbIIA0HK+k
         cRt3UE/qgh1adPlloThzb6UWGqfsAqhKUqkV24Djn/cy/jiqmU6c2TZul4HUWpYoDa8D
         9VQDvtGcjn1gq0tdcYwQGsPsA1cu1t+jHjL8Rgg/0s9ay2SCJNw3WklyJXm7XMz8BMIv
         aw0dH/s1fW9lf9V6DQ3Ikw6aqfp3PblS/c1JU9LLFag2RkmIG1Ui/oALP0f2NlkKTMwf
         /kxg==
X-Gm-Message-State: AOJu0YzqrrZco6O2w5qvkyifKvY2EyIXDlt9vx1gW98DZwT8tm2Vq0Df
	XLK4C0jqi4Sy2nxzLyq86xqTj45YfnIwCGECqcowUb/1+N6nA2wlVgrtItSWvGargMDiyTkOBG6
	xntDTmg==
X-Received: from pjbgq23.prod.google.com ([2002:a17:90b:1057:b0:352:f2a4:7e27])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:548c:b0:340:ca7d:936a
 with SMTP id 98e67ed59e1d1-354871ad6dcmr487515a91.18.1770148963801; Tue, 03
 Feb 2026 12:02:43 -0800 (PST)
Date: Tue,  3 Feb 2026 19:47:50 +0000
In-Reply-To: <8d055903-fe44-4bbf-a1a5-e0176343bf0b@rbox.co>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <8d055903-fe44-4bbf-a1a5-e0176343bf0b@rbox.co>
X-Mailer: git-send-email 2.53.0.rc2.204.g2597b5adb4-goog
Message-ID: <20260203200242.404131-1-kuniyu@google.com>
Subject: Re: [PATCH bpf] bpf, sockmap: Fix af_unix null-ptr-deref in proto update
From: Kuniyuki Iwashima <kuniyu@google.com>
To: mhal@rbox.co
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, davem@davemloft.net, 
	edumazet@google.com, horms@kernel.org, jakub@cloudflare.com, 
	john.fastabend@gmail.com, kuba@kernel.org, kuniyu@google.com, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, netdev@vger.kernel.org, 
	pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"

From: Michal Luczaj <mhal@rbox.co>
Date: Tue, 3 Feb 2026 10:57:46 +0100
> On 2/3/26 04:53, Martin KaFai Lau wrote:
> > On 2/2/26 7:10 AM, Michal Luczaj wrote:
> >> In related news, looks like bpf_iter_unix_seq_show() is missing
> >> unix_state_lock(): lock_sock_fast() won't stop unix_release_sock(). E.g.
> >> bpf iterator can grab unix_sock::peer as it is being released.
> > 
> > If the concern is the bpf iterator prog may use a released unix_peer(sk) 
> > pointer, it should be fine. The unix_peer(sk) pointer is not a trusted 
> > pointer to the bpf prog, so nothing bad will happen other than 
> > potentially reading incorrect values.
> 
> But if the prog passes a released peer pointer to a bpf helper:
> 
> BUG: KASAN: slab-use-after-free in bpf_skc_to_unix_sock+0x95/0xb0
> Read of size 1 at addr ffff888110654c92 by task test_progs/1936

Can you cook a patch for this ? probably like below

---8<---
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 02ebad6afac7..9c7e9fbde362 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -3740,8 +3740,9 @@ static int bpf_iter_unix_seq_show(struct seq_file *seq, void *v)
 		return 0;
 
 	slow = lock_sock_fast(sk);
+	unix_state_lock(sk);
 
-	if (unlikely(sk_unhashed(sk))) {
+	if (unlikely(sock_flag(other, SOCK_DEAD))) {
 		ret = SEQ_SKIP;
 		goto unlock;
 	}
@@ -3751,6 +3752,7 @@ static int bpf_iter_unix_seq_show(struct seq_file *seq, void *v)
 	prog = bpf_iter_get_info(&meta, false);
 	ret = unix_prog_seq_show(prog, &meta, v, uid);
 unlock:
+	unix_staet_unlock(sk);
 	unlock_sock_fast(sk, slow);
 	return ret;
 }
---8<---

Thanks!
