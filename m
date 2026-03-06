Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0882736CE0E
	for <bpf@vger.kernel.org>; Fri,  6 Mar 2026 18:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772822018; cv=none; b=NM6+VifvutpiSYRlmYTgzNIxT2ZNc8ELgZoRzhZK5NP/BFqLu5z6ucozaBwlZrlFpoGTNeNh77TEki51BlKw2JIvkfrnciWz1Xk3bzZKEn9Sm1siC6shoXymL30pXl7FksWuU4/mLRzJTj0bdxTLDxWcw1TXSvme8wxzWzo5DaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772822018; c=relaxed/simple;
	bh=C0FpvF+Eai8YIFcFjlslWeL22N9NQEVFyXAeA99g07Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CjD1LQdTC8ZE4hPJtFZKmkE2sGglo2j8IyLWPzg47UCJYqOqVn4wpGChhm70i/m3ts6vc3A11EIvjRTHvz8IzffHxx24bZnt6f9sJvrM2N7ra91v71w1oFfPHZp7COeFIv0SeZuvu5F6UErmS84mfnis7vR+qoP2RgM7U9IpmCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=AQel0LOO; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="AQel0LOO"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-661b08b04deso794109a12.2
        for <bpf@vger.kernel.org>; Fri, 06 Mar 2026 10:33:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1772822015; x=1773426815; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=w5lHZOXkujkn3ph72tYgDlAYNUE4LM5JcTk02pGHeUU=;
        b=AQel0LOO1Y0+P22FHsPZ7GNNYRSD6Tec6SxzUB08D0+nSIxVoM6ypWDES0g/8sN7cr
         LyU3Ks6F+1cy2LNpyPhRp7Hmxw0juMjXJXQeKPpRYNS16WnZd0jGMFSkXaobzYltSaDA
         7bXl6Vm0xIpxpR2Q7J2CEtkMBYhRm/4DAQ/KM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772822015; x=1773426815;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w5lHZOXkujkn3ph72tYgDlAYNUE4LM5JcTk02pGHeUU=;
        b=qB/miBJg4KdCvQckqxJOFGRqRfmNhJQSREjRQFLEUJ8/9jDzl8R2/BxVD1CGOUQr0G
         RwS0F00CJa5Gg/Fns4pJ+wzwvWsfkKWDE22iVoaAzPsNn4YvcmLRPENZcZHjxCVzV9gl
         XgfYPAcQ5aKp3/E93UxPjVnpoVCjDFZ/EMXQlJmmvli9908h3ejQkTDS4IFjEfxuRr5X
         d7KlEEgm0l/5TVJ3rpXXCQwqn5EexJsSDVY0I9SRxJrg2C+4VljTKBiAV8n7UlZzGj7V
         JKVg7gV4RIPC4ixAk4kXeCYkiaCfN2z3NBXjAHwMGj9Rq6Ha6uYBWhFO3gMSfOtmDLdT
         cS5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUYG6//vBeqT8k30SLEP9XbK/kyOW5FHkS/yumcPnlEJ/K+3QXIcyevLzLDdKAOHFbJ0fU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYBLPXyilCB0Hr6Y82C5w0WPGN4tDF3AznsDZ/Hi76ygHUxCdz
	07zO6823DW4hWsMSzaeomluuO+9lM2GKjVOUBoiFCDod0xYZd0mk/q6jmFa7laLNP25NqZgtuWO
	Xyj2LlKI=
X-Gm-Gg: ATEYQzy0yb4/JO/+Ayx2avf/TJnUeus4osOVDV2tRCInFs9NiMJyTC2bgtyRGLiGRfr
	G7Auhmoi+7ES7GzsBbz6H2eqotemgnx9TLW1anrnQ9XmRvz13FyQc4J10544DC1vUG5QZIK8bmQ
	cXSzMJgATRLkHAN0G4QSfNTCUp2qr/qHkfnsqJb9QG/Rulp11BSWkytK3iFageOpzj+fMSDVe9w
	Roemr+Sq7eCcaHIQZf5D/XXcJrAuKFVXOO6x5Y3QXcH0aRAcZD0mQBROcqMKHpo1H15npGTobU/
	cz+WWqfCB0jccMRYjUuRs8G4k7MjyZXswoAJxl7Vi1TaRJ8jxbsbCUPfI7tSjNwrdDnqrecYQt8
	iGZT74bbKHKGxF5MiDZttDbRBJT5cZpkzfICXaAPZY2+9hL8VnzvKwQM3tvvhribioiVwPdnaDE
	tjFjx/RGtvup6rlP0vmHB4lD/X0rXKtmiNsr+OkrGr7vZGyAsW3YgjXNuNREmEqeyVaoW/KwLz9
	O5+lbYWwB4=
X-Received: by 2002:a17:906:6a1a:b0:b87:f6fc:aea9 with SMTP id a640c23a62f3a-b942dbae379mr181638266b.9.1772822015160;
        Fri, 06 Mar 2026 10:33:35 -0800 (PST)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b942f13a451sm81864666b.31.2026.03.06.10.33.35
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Mar 2026 10:33:35 -0800 (PST)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-661b08b04deso794092a12.2
        for <bpf@vger.kernel.org>; Fri, 06 Mar 2026 10:33:35 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV9+0FosEfbOudlglTH368C9SUDrX280AMTwthdwzte6ic9Argh2WFs3Q1F8+4tc6AjL7w=@vger.kernel.org
X-Received: by 2002:a17:907:72d3:b0:b90:8016:cfe4 with SMTP id
 a640c23a62f3a-b942dbae36emr189809666b.10.1772821663491; Fri, 06 Mar 2026
 10:27:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1ff1bce2-8bb4-463c-a631-16e14f4ea7e2@arm.com> <20260306-work-kernel-exit-v1-1-8f871f6281cb@kernel.org>
 <aaroReSCj1qXUeQb@infradead.org>
In-Reply-To: <aaroReSCj1qXUeQb@infradead.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 6 Mar 2026 10:27:26 -0800
X-Gmail-Original-Message-ID: <CAHk-=whCiPr-cR3hVv=46Qo0Nw_vN422YUxqU0GmNai+KRtg2w@mail.gmail.com>
X-Gm-Features: AaiRm50t8TjmDHmMBt5Sh-GyOL4xotHpUKagWUMEUHoG2sdTM--QAxb3FwfabmE
Message-ID: <CAHk-=whCiPr-cR3hVv=46Qo0Nw_vN422YUxqU0GmNai+KRtg2w@mail.gmail.com>
Subject: Re: [PATCH] kthread: remove kthread_exit()
To: Christoph Hellwig <hch@infradead.org>
Cc: Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-modules@vger.kernel.org, linux-nfs@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Aaron Tomlin <atomlin@atomlin.com>, Chuck Lever <chuck.lever@oracle.com>, 
	Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, 
	Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
	Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, 
	Rae Moar <raemoar63@gmail.com>, Christian Loehle <christian.loehle@arm.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 6 Mar 2026 at 06:44, Christoph Hellwig <hch@infradead.org> wrote:
>
> More a comment on the previous patch, but I think exporting do_exit
> which can work on any task is a really bad idea.

What is the advantage of a module only being able to do
kthread_exit(), and not able to do a regular do_exit()?

I think the only real advantage of having a "kthread_exit()" is that
it's a nicer name.

Because if that's the main issue, then I agree that "do_exit()" is
really not a great name, and it matches a very traditional "this is an
internal function" naming convention, and not typically a "this is
what random modules should use".

So kthread_exit() is a much better name, but it basically *has* to act
exactly like do_exit(), and adding a limitation to only work on
kthreads doesn't actually seem like an improvement.

Why make a function that is intentionally limited with no real
technical upside? It's not like there's any real reason why a module
couldn't call exit - we may not have exported it before, but we do
have code that looks like it *could* be a module that calls do_exit()
today.

For example, I'm looking at kernel/vhost_task.c, and the only users
are things that *are* modules, and it's not hugely obvious that
there's a big advantage to saying "that task handling has to be
built-in for those modules".

So my reaction is that "no, do_exit() is not a great name, but there's
no real technical upside to havign a separate kthread_exit()"
function.

If it's just about naming, maybe we could just unify it all and call
it "task_exit()" or something?

           Linus
