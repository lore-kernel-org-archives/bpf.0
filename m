Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934B028C87C
	for <bpf@vger.kernel.org>; Mon, 30 Mar 2026 03:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774841826; cv=pass; b=pr3CZiAWEYYbbH1yNq3GSjRp/G7CJT4gdCa8l2kR2eUHVXZBHTvW4gwtwvj8w2ain8+5hTnszysnozufHmpP11GAaoOkBm0R284mQ6fnj8Y5V3W8ywsiYlW5HZPNmZkoj3HWx9bbJ878T7lu5/IwkhFhGteSSNKti5lAspeP908=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774841826; c=relaxed/simple;
	bh=G7Nlj6K5i6zCW/KKaz7tloA3TJ6yabT61LOu9o4dFi4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HYOY4M7lBgT+awQ3hi2yaoJ6a2l1pV0Ionk5nurtcDJtVhCU5ZUl845zoOQ7nVOK1aSvm4ucAMVLiTPW3cXMGDi0XJ6+4tbKXzDnrgwwedTYsUIqaLGsB8SMgosQK9d/p4nZF+OHHxxiqokLmoPEJv/LgIlk47qSLzDdqMtqw8o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ddxH8XNE; arc=pass smtp.client-ip=209.85.221.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ddxH8XNE"
Received: by mail-wr1-f67.google.com with SMTP id ffacd0b85a97d-43cfd96354aso316622f8f.1
        for <bpf@vger.kernel.org>; Sun, 29 Mar 2026 20:37:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774841823; cv=none;
        d=google.com; s=arc-20240605;
        b=eBPQkYZQPGQHMCNPQmxDpZ0Q+7pJ2YbT8u0lMCmm8upe+xOs4uU7GkRMrlXq49GXQt
         HE7pAPz7ywRxNSQLkk/CE5Dpnyv6sizz6ypnDk5XyKfyC3t3F8ZW6ujBJh4Sw5M4MnCQ
         Vu3WMzjDwhW2NlgQErGDbIBhyBKf9vE1mODYCQbpBloYaNpJwObwOI0WCEamItLPOu/9
         m5Evf28/wEtbpWe+7Z0IG/zU/dzhcdyxZYa6HT4qi/MNJdHoRBH7YDR3oo4OWT0j1u5H
         SL/6ZpOUTWtmcNxg20dOQxhpC2boY5fyn7K6Q9D7xMtSdnpst5M4T9U6H6lzjVFXP4sC
         Cukg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=G7Nlj6K5i6zCW/KKaz7tloA3TJ6yabT61LOu9o4dFi4=;
        fh=ma3un3fwOAapN3VYWTiGjplxti7OFe+6jYzqdBArgQY=;
        b=eUSxsXImKaSPaLxH4sOxJYrMCk5JiY/vuvqJECcqJx9fhrEwAXv0s26GiNeAC/Fjuv
         0kBOK3HNV0ymV+rWaWujLkVs5J0fiEOiHq4osVAwUR7Po/EIgGKpLZuAsC2MD23eG9lp
         /BSKXtg5ZTEQweTX/25KOFUTNtB46EXQVFoIHpaDIaeOW0+vNx2rMIIMDqGaOparEgKt
         r3dqn9fuATnL6f+sXegKFgDry1tzdY9SE5JaY3j1n1NZckaya28120KpGmtUAHQQPBY4
         nckV4mE3FSstW2vGPj3VyuVLv0J3eSUA25yGbUCNNI0Fc0QVwSlqlqchb5M2giHth8BG
         eCWg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774841823; x=1775446623; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=G7Nlj6K5i6zCW/KKaz7tloA3TJ6yabT61LOu9o4dFi4=;
        b=ddxH8XNELl/WsW6WqiVNy26wqpTUJplV22dQcB6f6cFtTFOWE7WUn/R1vmUcEdpMjm
         rw/KQQsseWXoUIjyOdqsVxH+rfHNSv67tIB3udAbKrjhlKyLqDJxz7l0uycAdOcZOrMU
         pce61T7Wesa4/RHorSZCPy0fV+tSrORu7QjXjKk1aVQTUntK26eyL222ZM5CAfZzHJZm
         ejgKn2N4Ak8BTOVetLaN2rDNhymG7yU1w2wDK+lNZbd9P4PT9zeBlE/Tmbqdwf+qAJ0F
         069u+8USr2jbZoQE4QsazswIeuMYCs3jdQo8hxi80rMY8wgptHtfJbF9fwEACjQ9g7rI
         m5xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774841823; x=1775446623;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G7Nlj6K5i6zCW/KKaz7tloA3TJ6yabT61LOu9o4dFi4=;
        b=lNnQl/JAL2vTxrZohkP4PutR+iyblQ2EYJL2pC21kafsvXp33VOP/iALvbov8lD4tk
         xGr2X/n2sxa6leLRATJFIJMaw4mwJGZv1daPlN4M+No0lkBvBOrEpEYBkYJLF1iVdPSW
         D3OZ9dmKxULXROw4kRmfmFi1mviLIol3fTzlUQNOPmUdkxwOMK5GzpYPjAAOiozBU73Q
         peAF0n2PLPivi0azPnJ3j60DXgm/s72VSgUTdB4/EMB1L5gYwNwA7ewI7crJ4lcG4gAT
         +CuF58M3aIcjcY+Sl9uLMEbNXbKk3C4bVvzsI+z4h2H1tW32gu9KAXmtrIu/ntTMEl9U
         U7Mg==
X-Gm-Message-State: AOJu0YwXAPVWc6C8oV4j8dXYKiVdm0u4DdsFwbFq91dJyEBAiYoEqeZ+
	N7UJTPYdj6TWqIw0/4VaVQ569fPK1AkR4TzSWqYAfQupO7G5ABJMTeDvaCIIIWHHsS1u2anEM82
	xqzghiByRJUqEIMWhVhP6wPmchfzR4F6xKGTT3ACMag==
X-Gm-Gg: ATEYQzzg+u1FiE6UmegftCwFItE7+5rbsP+HPaOU+NZR+V7/XFVpkiaGrU+DBbEDRI1
	TKsUP6IZ7qNDuk6tILTHWr5LaFyzKFhdN3SVhMwFIyvLcfll4uaHGESSlWm+MGDFNeTBtHJ+E23
	6Kp/EzqL/BYwoDDnyrLAAZ6Qjp7z2rql4hVUx9TNdDQN0qo1q01fMKCOTnnMiEKiE0diWoYj9ZB
	7cTG/H8eAnGOpySFL57fUPPjnwUtSDpIQw9cedaynhGq+7BQPLg4IhBpwSpRHJKiahHVQ6O8IWJ
	Wbr0zIGTWUV7gO9bRPYMkLu68f2EGWMGbjBOjeUn/8bhf6xMYTa/Wirdpvz2
X-Received: by 2002:a5d:5489:0:b0:43b:a21e:9c19 with SMTP id
 ffacd0b85a97d-43ba21e9c7bmr12515964f8f.38.1774841822421; Sun, 29 Mar 2026
 20:37:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260330032124.3141001-1-memxor@gmail.com> <20260330032124.3141001-2-memxor@gmail.com>
In-Reply-To: <20260330032124.3141001-2-memxor@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Mon, 30 Mar 2026 05:36:26 +0200
X-Gm-Features: AQROBzB_G3mapjPE8QBXK1QnOTgSfC6JJJkvHpgb6i-bzAciaDy058kgqMh3CHc
Message-ID: <CAP01T77HcqyBKZRzRbLbHuZeskJ7XJ+FU2GQpZX-WXTCPMyikw@mail.gmail.com>
Subject: Re: [PATCH bpf v1 1/2] bpf: Fix grace period wait for tracepoint bpf_link
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, kkd@meta.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 30 Mar 2026 at 05:21, Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
>
> Recently, tracepoints were switched from using disabled preemption
> (which acts as RCU read section) to SRCU-fast when they are not
> faultable. This means that to do a proper grace period wait for programs
> running in such tracepoints, we must use SRCU's grace period wait.
> This is only for non-faultable tracepoints, faultable ones continue
> using RCU Tasks Trace.
>
> However, bpf_link_free() currently does call_rcu() for all cases when
> the link is non-sleepable (hence, for tracepoints, non-faultable). Fix
> this by doing a call_srcu() grace period wait.
>
> As far RCU Tasks Trace gp -> RCU gp chaining is concerned, it is deemed
> unnecessary for tracepoint programs. The link and program are either
> accessed under RCU Tasks Trace protection, or SRCU-fast protection now.
>
> The earlier logic of chaining both RCU Tasks Trace and RCU gp waits was
> to generalize the logic, even if it conceded an extra RCU gp wait,
> however that is unnecessary for tracepoints even before this change.
> In practice no cost was paid since rcu_trace_implies_rcu_gp() was always
> true.
>
> Hence we need not chain any SRCU gp waits after RCU Tasks Trace.

... or chaining RCP gp after SRCU gp, rather, the commit log should
probably say that instead. The above might be confusing.
But more eyes on this would be great, I went back and read a few
discussions on why we were chaining RCU gp after RCU-tt gp and
couldn't convince myself it was necessary for the tracepoint path.

>
> [...]
