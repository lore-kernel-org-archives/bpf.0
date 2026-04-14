Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com [209.85.210.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB39438E5D4
	for <bpf@vger.kernel.org>; Tue, 14 Apr 2026 08:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776154090; cv=none; b=qlRO/36+1Mh6gC94Tr5Vkr/sIm5sBRLCDN1WnRa8XBBl2il4DjmHyOdjRwqyF7jxu63QTFeslLBlLynmfjqAloJ/X+ZGcRs7cN759Yc4VR8omdMzMpoSkDdD6FCRlHSt1VEySBx4jt+U/wTiSH+qkIcJeqiUMKlhhxXAAHjJztA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776154090; c=relaxed/simple;
	bh=NCU7HC1t3iEDC4IqX2izve0FBoiDBcxRNyhBdT9YCoc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=sK7/tvRRY0GyIsVjatPO1GAvf7xWZdnZfYe+A3jVYQUvAJfzd2G2VbHsbvgAgQK9PS2EVFh6m+gzSKf17Lc9mhTKVYXSkbjC4L0SKzm1H0Tf1FuB8SvGRNCQspBihylr/yEGSrN/Yy62HgPgvHF89aS/bK9/S040pg+zXBQInIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-7dbd4fe0e15so1390450a34.3
        for <bpf@vger.kernel.org>; Tue, 14 Apr 2026 01:08:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776154088; x=1776758888;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NCU7HC1t3iEDC4IqX2izve0FBoiDBcxRNyhBdT9YCoc=;
        b=FC8+hx/WOvFK4AJZfkWB1yBbZyu+ibSQwuiNp4xdeEEEWCjEqApm32GCfTOfAxaZwG
         +uv0b+hNzzeX+JXfkD+osR+v0rBDmlq0Mqc7X/OrMJaXmEIGC1las7XNnAygkRbDVbx5
         O6fo5NTatrhY70jEr+6YLKQe2lqrtZ/07uFwefDyzF/tQstb+yvSId8Mm0o02SCuzhbH
         9srsUosdyR8HUQwP3GvAH7Vs4UsMSUPC53qY+nBUTV62KvZVpsWUw1ogCJUhqJF+0ua7
         RsT1sYUly9/K5uoM22pGnnMDDIt/nWf6nnHlw8oYC1xfOO/AW4vsAXRvFDDC78wsWa6J
         Nu+A==
X-Forwarded-Encrypted: i=1; AFNElJ84WGFqkI2BDYNT3rSxKEANfr9h/Th0YNRYG4nmBAd4VqIUdLaSTGV0VrhTmSMhM4HyPMQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxzf0Hb4FGB0jPXsHPQKE3awqdniM2+/C6LUOP/QpjCg/D1EQxA
	i+3IYE6V2GqrbMDXwmdALfmefat3x8dAFAmZK4HC9mxl8ufXQGaslgxtcWbEJTFomlgRr7nlnWx
	bsd/oGcW4Mj4tNfrHA8PTA5ynLcNj4jwGJhCfLW0tDAQuLwN8zuc/Sqt8jqU=
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:8183:b0:67e:1c67:ebd8 with SMTP id
 006d021491bc7-68be7ee1b88mr7508599eaf.40.1776154087806; Tue, 14 Apr 2026
 01:08:07 -0700 (PDT)
Date: Tue, 14 Apr 2026 01:08:07 -0700
In-Reply-To: <41689f2e-8786-49a6-912d-f65e48245a61@kernel.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69ddf5e7.a00a0220.468cb.005b.GAE@google.com>
Subject: Re: Re: [syzbot ci] Re: veth: add Byte Queue Limits (BQL) support
From: syzbot ci <syzbot@syzkaller.appspotmail.com>
To: hawk@kernel.org
Cc: andrew@lunn.ch, ast@kernel.org, bpf@vger.kernel.org, corbet@lwn.net, 
	daniel@iogearbox.net, davem@davemloft.net, edumazet@google.com, 
	frederic@kernel.org, hawk@kernel.org, horms@kernel.org, 
	j.koeppeler@tu-berlin.de, john.fastabend@gmail.com, 
	kernel-team@cloudflare.com, kuba@kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, sdf@fomichev.me, shuah@kernel.org, 
	syzbot@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"


Please attach the patch to act upon.

