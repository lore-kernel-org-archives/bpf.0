Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com [209.85.210.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D94663AEF2B
	for <bpf@vger.kernel.org>; Thu, 26 Feb 2026 18:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772130619; cv=none; b=praRuSysJ86UZUUtFQPveCIUuzvp8aj2kjW5EKp4dv/QzDkrj7Xmf0R4EE6ET3ITEDWN4xMMaPUfR+zRHzEeuAiVfrAeKNYkwJXHRA2C7CKOkNFisGnNUhWY4E3EFe68ef1FZGJapxsxhpYCCV05xmbNCZDIMylrDYOI6j9k6zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772130619; c=relaxed/simple;
	bh=DjcBVY8mJqbGJnCRObWENCx0c6xRt7QNzm9li1dg71c=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=RovLTC4uuT3A5wZP1z36l7J/4nAEbItliKMy1Fk9PlnM/waeyhY6qj4tIoQ9NJd398gIiHVzDv1IbvaxweCLHK6OBvCLo8jB1ixjfmflLcY00TvgfgBcL+h9ORUPjt210zgbPNF2f+37SVSSrHSMJVKYvqR3syo5vmWg14X/r3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-7d195fe3eb4so22581908a34.3
        for <bpf@vger.kernel.org>; Thu, 26 Feb 2026 10:30:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772130617; x=1772735417;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DjcBVY8mJqbGJnCRObWENCx0c6xRt7QNzm9li1dg71c=;
        b=mDDntpSXxQSWjfTh2CRjkrYprWfbiHBTZ2E3IjC+Whs8UTGxd628rA4xUK0V/R6aCo
         oQF4+mQTFXbqUhyZh6icUMnsFk1T3bMjvCaIRr82zWDveHog8FO5FwUt6OvPY4hNlYkn
         J0X5xJSCLrGlh13u3pLUOC93gVRryxBXvdHXiJFRZi20ikYpEEQgjGk8uf4q/rj4thJ1
         7q6/r4u0hYi7KrpS/q2hugklYBeixbn2r424QTL/WoWj3EhzkqvsOgna+/SYHDrgBaPO
         mgLji6ZbM0zwK1+GjNzbg/LPa/BjHnGNSU7CpnVUiy+SU8wy5JxUJq9USYLmfHgMUvs/
         0zpQ==
X-Forwarded-Encrypted: i=1; AJvYcCVjIO0Nm/iVkw+kFD5gaxcZNBkC65fUN6ciVEaQJwjesuzjId4W/WCEXWjsSFyjIqo3TAs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBSW1yQ/9bT8HttXTCSKBO6DAmauFbfRoNJOYFK92YEFr/ffPT
	ad/WzqTwGt80Ue5sNate8y9aV+DmoYvjyBwP9aGHfS4Ni/8CtmHsTsYYMOLsb+XS2ZR3s469e9U
	t94hAWlq3rxmwVQiKLx5+Y7laI2nQT1Jczpes/NTzd92pkZ/omNdU0TAEQ2U=
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:3105:b0:662:ef26:1505 with SMTP id
 006d021491bc7-679faefbbe0mr174206eaf.46.1772130616866; Thu, 26 Feb 2026
 10:30:16 -0800 (PST)
Date: Thu, 26 Feb 2026 10:30:16 -0800
In-Reply-To: <20260226182822.1734308-1-memxor@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69a09138.050a0220.3a55be.0007.GAE@google.com>
Subject: Re: [syzbot ci] Re: Close race in freeing special fields and map value
From: syzbot ci <syzbot@syzkaller.appspotmail.com>
To: memxor@gmail.com
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, kernel-team@meta.com, kkd@meta.com, 
	martin.lau@kernel.org, memxor@gmail.com, paulmck@kernel.org, 
	syzbot@lists.linux.dev, syzkaller-bugs@googlegroups.com, yatsenko@meta.com
Content-Type: text/plain; charset="UTF-8"


Unknown command

