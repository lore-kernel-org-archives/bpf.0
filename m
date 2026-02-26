Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E7C33263F
	for <bpf@vger.kernel.org>; Thu, 26 Feb 2026 17:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772127484; cv=none; b=AvLtY7IDmV69i6CM79yG72yNkf/iz3GktI61up/4g9HA80omH1cpYFlwc6E2NegOhuwjjP/zOpa596ECmnGtlcOY5eTet3DcN1ZfQedugg1hgtXog5XIFEIrmBmWoeaD96GEFbH5vcc8dwMn9HCQyZazEXpOMtgzp3KyJkp6CEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772127484; c=relaxed/simple;
	bh=DjcBVY8mJqbGJnCRObWENCx0c6xRt7QNzm9li1dg71c=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=ONZn9AIUJRku5T7WaqhiT9s+LlRNq3qvrJvkY/+O7qOHiT0u+pQqMdqpqp1EDPOeYrxI4XK2AFG+hS0riao5phbb/WVWNIMDNvDnPsTfQc4M4ubiH/N2j2S5tgUge1O0KvbeKExhUE6yxf+PwKYqMJCfeHEzNXcDYaGI2XizPt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-463a075e177so6226400b6e.2
        for <bpf@vger.kernel.org>; Thu, 26 Feb 2026 09:38:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772127482; x=1772732282;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DjcBVY8mJqbGJnCRObWENCx0c6xRt7QNzm9li1dg71c=;
        b=b6jxuJu9B08keh7mx4Ayior96jCdYsLJzLc0aORUFhJBcUjHXsU5JnFRFZROpFh3zI
         b54nq+lk/1cWzdd4TPmzlaoci9/xMY0ex8CQnZtYcJrcQJUkWUl6os9mqXUf+Wtx76ES
         GV10gw8e7DHzaF0WvXGNMZEZOuUGbBHzmX4t/pYK23iWHHItFjUeKx1XbUBTW+fFCHxj
         auDC0+uavs5ESQCzmQwCixSkS+aAJoylz/6A93zmoWSuJi+NZyQ65JOuN2d+llSv6KV9
         /SbBhJJSQYvVjMfWutXtR51hsCoWP2FloGxm3M8mfz25B4ixnjSzsfC+cBqa+iZl8sa3
         /b2A==
X-Forwarded-Encrypted: i=1; AJvYcCU6kHKvguPkTZm2rJQk0X3V0mpcqNVzOWGBiAMHnNCqqhtelLB54BQWbu3cujqX9gPy0So=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRQR3wJRV0PbQE+8ASEXyBtuMpT348MxnoK2qmcrJ22dxiLCM+
	rsPO/jOd6VeVzOkEPX5SxegNy654nEsP/jToBi6p6KAgf82NAzOXiSVnEAFSwCyjk97WRHUZkEF
	RrM/OEGHztdfeTRlZKhizDJJuzHrQCJ+1lDGlKN3FoeMhgpYMyikA+MBlJiI=
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:1c89:b0:677:fc0b:dc with SMTP id
 006d021491bc7-679fae78a73mr50070eaf.33.1772127482186; Thu, 26 Feb 2026
 09:38:02 -0800 (PST)
Date: Thu, 26 Feb 2026 09:38:02 -0800
In-Reply-To: <20260226173657.1285415-1-memxor@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69a084fa.050a0220.16c224.0009.GAE@google.com>
Subject: Re: [syzbot ci] Re: Close race in freeing special fields and map value
From: syzbot ci <syzbot@syzkaller.appspotmail.com>
To: memxor@gmail.com
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, kernel-team@meta.com, kkd@meta.com, 
	martin.lau@kernel.org, memxor@gmail.com, paulmck@kernel.org, 
	syzbot@lists.linux.dev, syzkaller-bugs@googlegroups.com, yatsenko@meta.com
Content-Type: text/plain; charset="UTF-8"


Unknown command

