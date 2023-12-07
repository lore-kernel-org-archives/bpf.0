Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="X5CEiJvr"
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37DEA110
	for <bpf@vger.kernel.org>; Wed,  6 Dec 2023 20:33:05 -0800 (PST)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-5c85e8fdd2dso2613037b3.2
        for <bpf@vger.kernel.org>; Wed, 06 Dec 2023 20:33:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701923584; x=1702528384; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zK8ZfULjJVKcXhjh+yb+cqPXWpzI5K9jSdBQcxmouRQ=;
        b=X5CEiJvr2yruLV7PpkkivDSQRhB3oN7E5qNyLl7tmCWP1gKxIc+eTE2VUBL75nHNqV
         OPCbQrNdFmFTois6fTb6siMsm3QiIs9bEJ9SAj4lSjIWwZdonESv4cUJxUclYm09svpl
         YdpRHA0MPx/ntouyuANYv88gmUYi6VFTXUxwM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701923584; x=1702528384;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zK8ZfULjJVKcXhjh+yb+cqPXWpzI5K9jSdBQcxmouRQ=;
        b=gdoP3ZNwTo1siNA1UpWgIkSCGpC9+seS+fLCkdIFm1bHbxPx6N0qYd6mCq1w7dHpo4
         GYkuopoMFLUW25M+2UKZ7dOka85mIB46gcHzFS38TJKzq6AJK3qOzCM1rsBkJfRv2uJv
         0gluXAyzZo2r+76kWP9SUfuVu/ILiA/0nkhPyC+7Vn1UVLRsWflv/x4Szuovk8L1LflT
         1KLZaeghv80k1cILkt7y1clJhKWYEyAfxYPIYPTUH1y2M1j5EkUAspx1bFpJLBY72oRd
         JykdYblnwJqqUz73bJJve6Ugu9iPCjo106Bx7jaYzvq3IWgFYDuULI+ULGqf27ScAd99
         xEpg==
X-Gm-Message-State: AOJu0Yxz0g+XwpZEZM1qRTMdoAa2kjpIJKKHhxx0Fh5lj/RELLEbk8x5
	KJxBXxxwLhXvTMOrz3Yw1SnPOaI5RDhaFvF6EX3mcxv4uljJxdWgdAQ=
X-Google-Smtp-Source: AGHT+IEK4TQWqxf/pn8YeY6qnUMvTb4PlFXRNjvXyq/PHkdgndwE3BDshVMQoQrtn4ZarrtBgEo9d+b9WkAweH7fHWI=
X-Received: by 2002:a81:4426:0:b0:5d0:6e91:d6bf with SMTP id
 r38-20020a814426000000b005d06e91d6bfmr1648953ywa.21.1701923584157; Wed, 06
 Dec 2023 20:33:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231206073624.149124-1-jiejiang@chromium.org>
 <CAEf4BzZvuFcBMvejMoQVCPaRsDQRXmqAvVxJ-o3G=0Ojf0RhtA@mail.gmail.com> <CAADnVQJUzS139OK9_CvxN7yAGdhZSeEaOvROANkfaXwQOU84jw@mail.gmail.com>
In-Reply-To: <CAADnVQJUzS139OK9_CvxN7yAGdhZSeEaOvROANkfaXwQOU84jw@mail.gmail.com>
From: Jie Jiang <jiejiang@chromium.org>
Date: Thu, 7 Dec 2023 13:32:53 +0900
Message-ID: <CAGUv5MirO3uoANcqWD4Y+q0Hi4ZkEmOpmm6qoGYs377zbBHJrA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] bpf: Support uid and gid when mounting bpffs
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, bpf <bpf@vger.kernel.org>, vapier@chromium.org, 
	Christian Brauner <brauner@kernel.org>, Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 7, 2023 at 3:20=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
> [...]
>
> The token series are much bigger, so I applied them first.
> Please rebase, resend, and keep acks.

I have uploaded v3 to resolve the conflicts and also keep the acks.
Thanks!
