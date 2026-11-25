Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795581890;
	b=imXazBGi/x5AxImgX47an5fJwX6zxa3v0bQvMH58/ymvAzaWwqnUfBoeb3XelOM8z3VR
	 UVyzo71XWk7bbP4HHwFYMwRT3tfe44aGWAM4H32tvwgXy2Wwubu5tcQu11/wj4dzEYf6n
	 W14sS/6c4E9k4Ughjipqgscd6EzzZpIYr+yWdSdE5X3dvQZoYPr9fGboDxzzUBJXdidaX
	 MF+E8DCR14+DNpsdyeKf9U81gzdOyyYXFW7oezQRfw2B5WJoZN4K+P38wL9Z4AXhBk5zF
	 oYonSoknq9R+Ij3l30e99nqmwo19H2tHtJfGqWk3haD1wGWx6IPc03qugqxkVqyTPag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795581890;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=v6FpQHxVaNrLdhGFym3SkQkn6ujfmWh2yiSz1Y8qURs=;
	b=dZd0jlzNtAOBJB10oRD3emWm7cWJ56pU9ihkSBQa+C0Xt44MitCGbrW8xwpoHWZTn/iD
	 j8Lox28s3bNW8iKa9CS2yjSexHQ7YI/TyHVgfvPMJsDkTMEpX5XiTgwwVQPB5OcpQGAHU
	 z81GgMM5k50TQOSyjM+rn8TFaOwEqdQnncceKLBGJpd5WNzJrS/SUWTStr5svUeE0k/9K
	 ve7ANEfozGlEd5/FgXI0jhn/hu5OmKJcSywG928lE+9gwu5GnkhOIznOZmkvct01IL4rZ
	 GzcW7oOLD/uEISViIXDDBagU528VCsKWy5F9MaxCDO87EMv2KuDT8psD+sWVFkFENFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="TMo/DuID";
	arc=none smtp.remote-ip=209.85.215.179
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F0E1606A681
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 04:44:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4F0E1606A681
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TMo/DuID
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-cc751eddf25so3466349a12.3
        for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 20:44:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795581890; x=1796186690; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=v6FpQHxVaNrLdhGFym3SkQkn6ujfmWh2yiSz1Y8qURs=;
        b=TMo/DuID8ZXu89TGA3aapdoCBdFqMqBHps+wl2gdkOnWevp5ELngUw1u2D61AW34/0
         dzJ4bqPKw09NcZ4SqqvToMQ8YqDZHKil9107dPmmqOlAykABlqiPsmrJZoM0nOcnGLjB
         PRPCF0q0QGVBlacBx9v4yYi9z5SYmuN27LTMgRr6NW5VwZuHQxwiAvfmwHMEIy2fB9mA
         G9tdb658V9bv36IWLax0+zmZNT+Cv8ZfcdUGz650T2g7vuDeHsic12YdFBY9XHkbjkvM
         5Kz7QJrtfYdwFlXPgF13Puomd5/qIu/ZpcKxgLQA1r5WXyf+JdxsfcsJABKHmvy8psgs
         Vx9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795581890; x=1796186690;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=v6FpQHxVaNrLdhGFym3SkQkn6ujfmWh2yiSz1Y8qURs=;
        b=ZmAlfgsMwCWepcKlLH1jITMjz26mWnQ0vhk5Y/MYnzsreJU3i4mIEqigIAIb91Eo9r
         yVd4kQ80WsyxeTCjr1ixytpTphSgMDvDrEtM7Bxi+2TSyKGI0ufbbFro0zA7M4KcRsPS
         A/TM2IECs+A9f2PvkkPJL6pIqfYVYAMtvUclB45Ppnv9UOuyauFlBsDVQW7YmCeM0hOA
         XRPJAlL0nKj7LPDQuk5KUcjw9Hj5UNJ7DBeaOP+NbogKZgFfLO5UTgRiLDskbFzDJibT
         5xu1IuI881MZbFl7nVhNX9b6eReM13M720zdvdWNFm7PQvUkF/PYLNWfvaHg4jVAI3/o
         Adzw==
X-Forwarded-Encrypted: i=1; AL+hErH/yHP/7d4fqKQIaWBLn7WByemOruRKxcwMru/haqNd1Wzov3T+TTP8BYvWhjnkVFo4Axg=@vger.kernel.org
X-Gm-Message-State: APuU4Z8efv4BiucVRhdNPTkpM4ZbahzVYs+UNH/0ByG/SxBY11YgFIh9
	rS/kT5zyn0q6q67o3MGAAaMN+ZacMsWaXiCz9Cy1VfQrw7l/3QFpYQhA
X-Gm-Gg: AZFdTZe9S0xDzNpfwS3fqtbThlk8P8Chh190pbUUwM5NY1GkvztqnMRHIl2TlLUbw2A
	zkUSpfdr+pYC96YOj8uj1J6x58oAUSau6rG7rf1AayppBKOQlv+9vfnfTCT2dyeGmc0Db45QGeV
	cnkKigEAHXk1mY5icZLpN+wlsoHLYBuwzgKynvlJYnoaBdSS7F5R98FtgP7SIf+Bm6zlr4y+OqS
	d+MHiAV5QIbwDaETtcQM5DOZb3qyd2TdS0WeaptJSMDhKMCAOQSxV8WyCABBmML/M2UhEpq30IL
	fCJVE1V5NILdVqM3IYhEbLGUv82RplD+4IYsQVUt9W2tDWEaiVMkCE2NcHZplvQCNko4PwLsLNC
	8XpTNzfK7vBmYJPIJs5sf+Fo11JyhgisonOWVsgWpnm8GVpO71e/QU5avvPdavdLkCqTV6WB/rE
	xcWeQVPw/ORIA9+OpwvKxzYqBGmvd5T4Z8nuw0dLW9Y7qkz0FhZdNPMI8Am5g7zf5CtIqmZadAW
	u/7OUJR2qO4l9SZcmFcUeza1d+QH4JcrIKqWm+nF8Luw7PnJBO93S52Sosy5dlPNH2bV5Br1v38
	+F6mIuUD2GvoFf5pWmNxMOcEftTpIaLXsrRElgC2RPjxPhgaDkGpWB+xPAgalodUdidxGt8qdSz
	i62uXJNCNC6oDotZfhuC1T/wioMtIvsfjhg==
X-Received: by 2002:a17:90b:3c06:b0:3b3:c9d1:9b65 with SMTP id 98e67ed59e1d1-3b41c94d32emr15745867a91.51.1795581889481;
        Tue, 24 Nov 2026 20:44:49 -0800 (PST)
Received: from localhost ([153.61.198.254])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b409330ae8sm28659401a91.7.2026.11.24.20.44.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Nov 2026 20:44:49 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Wed, 25 Nov 2026 04:44:48 +0000
Message-Id: <DN40NNXNVB6R.263I8UYD7B329@gmail.com>
Cc: "John Fastabend" <john.fastabend@gmail.com>, "Martin KaFai Lau"
 <martin.lau@linux.dev>, "Song Liu" <song@kernel.org>, "Yonghong Song"
 <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>, "Emil
 Tsalapatis" <emil@etsalapatis.com>, "Ihor Solodrai"
 <ihor.solodrai@linux.dev>, "Bradley Morgan" <bradley.morgan@linux.dev>,
 "Paul E. McKenney" <paulmck@kernel.org>, "Frederic Weisbecker"
 <frederic@kernel.org>, "Neeraj Upadhyay" <neeraj.upadhyay@kernel.org>,
 "Joel Fernandes" <joelagnelf@nvidia.com>, "Josh Triplett"
 <josh@joshtriplett.org>, "Boqun Feng" <boqun@kernel.org>, "Uladzislau
 Rezki" <urezki@gmail.com>, "Steven Rostedt" <rostedt@goodmis.org>, "Mathieu
 Desnoyers" <mathieu.desnoyers@efficios.com>, "Lai Jiangshan"
 <jiangshanlai@gmail.com>, "Zqiang" <qiang.zhang@linux.dev>,
 <rcu@vger.kernel.org>, <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next v2] bpf: Add rcu_read_unlock_special() into btf
 id deny list
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Sechang Lim" <rhkrqnwk98@gmail.com>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>
In-Reply-To: <20261125040106.2200628-1-rhkrqnwk98@gmail.com>
References: <20261125040106.2200628-1-rhkrqnwk98@gmail.com>
Content-Transfer-Encoding: 8bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Tue, Nov 24, 2026 at 08:01 PM Sechang Lim <rhkrqnwk98@gmail.com> wrote:
>  BTF_ID(func, __rcu_read_lock)
>  BTF_ID(func, __rcu_read_unlock)
> +BTF_ID(func, rcu_read_unlock_special)

This will break gcc builds with KASAN and WERROR.
It was my suggestion, sorry.
The other entries are global functions. This one is static and has
one caller, so gcc inlines it in KASAN builds.
The splat in commit 684c68d92e2e has no such frame:

  rcu_preempt_deferred_qs_irqrestore+0x74/0xed0
  __rcu_read_unlock+0x290/0x3b0

On x86 __rcu_read_unlock() is 0x2f0 bytes in commit caf3ef7468f7
and 0x120 bytes in your log.
Without a symbol there is no FUNC in BTF, and id_patch() prints:

  WARN: resolve_btfids: unresolved symbol rcu_read_unlock_special

WERROR makes it fatal. Sasha fixed such breaks last month:
https://lore.kernel.org/bpf/20261019211006.2574350-1-sashal@kernel.org/

rcu_unlock_needs_exp_handling() also runs with .s set and no guard.
fentry on an out-of-line copy recurses the same way.
It's normally inlined, so it cannot go into btf_id_deny.
Plain inline is not enough. Song's series drops notrace from it:
https://lore.kernel.org/bpf/20261023011049.1164625-1-song@kernel.org/

Two attributes in tree_plugin.h on top of your patch cover both.
clang builds tree.o with them. I didn't try gcc, the BTF step or a boot.

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index ae5d21b..5f2f56c 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -689,7 +689,7 @@ static void rcu_preempt_deferred_qs_handler(struct irq_work *iwp)
  *
  * Returns true if expedited processing of the rcu_read_unlock() is needed.
  */
-static bool rcu_unlock_needs_exp_handling(struct task_struct *t,
+static __always_inline bool rcu_unlock_needs_exp_handling(struct task_struct *t,
 				      struct rcu_data *rdp,
 				      struct rcu_node *rnp,
 				      bool irqs_were_disabled)
@@ -745,8 +745,10 @@ static bool rcu_unlock_needs_exp_handling(struct task_struct *t,
  * Handle special cases during rcu_read_unlock(), such as needing to
  * notify RCU core processing or task having blocked during the RCU
  * read-side critical section.
+ *
+ * noinline: btf_id_deny in kernel/bpf/verifier.c needs it in BTF.
  */
-static void rcu_read_unlock_special(struct task_struct *t)
+static noinline void rcu_read_unlock_special(struct task_struct *t)
 {
 	unsigned long flags;
 	bool irqs_were_disabled;

Pls fold it in and build with gcc and KASAN.

Please cc Paul and rcu folks on a respin.

pw-bot: cr
