Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793113313;
	b=M5c3i8MFxaq6MPt68P4JDTvnu8E3lKMwlJALPzD8cgOfmzgzMQ3RCv+Q92bK+iHi6pwg
	 +wPNt+qVT0Ew2kZ62xH3H/AIav4sMBaSskd3sdwWo1TD25YegMXaJH0yh+odsoR4N4XlX
	 bse3to37OBO0Z6rIy5f8QxQ5lJYFfFsakqqICdrwHeyIdckqYG/nzKfNAV6kgFnj/3YLF
	 Ta6ZBiK0S9RCWaOoGRIhjhQrVxivFvxOprzf0aTp6ZbuBA9Prx8P1fn9Mt4Gqx8hpBlXr
	 eeiOczApI+3TTwsYr7oms/8Zo34sD0EH8bPP/dLCw6GPwTt7nzop7Ys8BMXvRVQr7WA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793113313;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Mime-Version:
	 Content-Transfer-Encoding:Content-Type:Date:Message-Id:To:Cc:Subject:
	 From:X-Mailer:References:In-Reply-To;
	bh=4JSSeMn7jD3hzJLmiAPL5D8xsSZOgnxpk+LkLJ9f9Go=;
	b=AY6vRKDFWwCuK8gWFfS+AUkF9G/XiuGl2bNDOjlnQOMoZ5ITS/vnNRvp41EbkdhUF8YA
	 44FJJLZmQJ+GCwPUTiDbFX6A70AwLrg71+K65ORgnMxxj/mKZvwls9Od4AdXDs9MUkjAl
	 JFTzlwyAAb+smNoDiVYlSo8Q1/M0L6r+zGFOyItR7EZOaUH/f1GhZGOXUti9X4CKfdWCu
	 SaDVYfnLU8TvGJJymuAo3/RDOJ8C7niiGG4Lmjw0KbO7NDhmUtwIozWWJE9dT1lxK1fki
	 4qXEJ0jZKplqbwOv0CD7qJYZnEP5WgtUOZSZpexC2ZRdlqcH6N2UE9wBtQYIJxolYhQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Y4RCI7rt;
	arc=none smtp.remote-ip=209.85.215.176
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B040606BAA7
	for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 15:01:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5B040606BAA7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Y4RCI7rt
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-cc502d509c0so8670a12.2
        for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 08:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793113313; x=1793718113; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=4JSSeMn7jD3hzJLmiAPL5D8xsSZOgnxpk+LkLJ9f9Go=;
        b=Y4RCI7rtBOy5b9y0FhCXLw7TxjLGKoqP7U6NlrFD6q8Ld/t9Vb2wuRj4d5nvLDYNmW
         zMd4eYz+V4fCXjWsiScL3PR0/jOkJbs4iZB/1XrWm7L4dnIYl6zkHE/78s3Hrx1q6Waj
         oRJIZTMGG7SO+raSfVOtWoAkLKKYIlEQb+1KLlQzDppE2+agB1IrvZx0fPK0fPBmKjT9
         tmPkvXERI+kZg+dU9H69n1AXCmu2e6B/KgFFjnm96LtaYjcsqwxw+UdhXxmTEqT0+3z8
         iwxmEvIrStDaVsjlO8tSuKQpCLA7DgHptE2QvFviEIcgFaBknjMXm9B00tSUipyu0hGO
         dOSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793113313; x=1793718113;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4JSSeMn7jD3hzJLmiAPL5D8xsSZOgnxpk+LkLJ9f9Go=;
        b=qx3JVTObkCuzPqA8zzf7el7p+JAOLGRx2JvJPiVRBDdTicoN6adGMDsADZunUt20W+
         rEiYFhAOWvqZLUD10zyNVmHFAipsAvhiZzV7jKG6LlGPX7LA+o+4IOyMXfkdpDA9winj
         8h8fIi36LyvGNkYmK8X4t3fomDY1ZlgOTvTSfZHzMnhmjeGzILeT+EgkkMCIsOs8Oe64
         5cGEzH9+Qd4jY1e1Mnijq/0Qg8YCLVS83PyMuPOuQYbuhKzwjWy09ut42AmDzBDA3PaL
         Gtk9w26/tmFKTgiM5NowJSWseUy7EmNLkXDMveQyRXjcsQvmwq9/IaBBVKjC7LQ/wGWi
         ashA==
X-Gm-Message-State: AFq9FYJKiqZnBUnXCC2wDrT97ZFDfOpMS16oRghfvGUrKG+3iOzbMjfm
	f3EvVd5SIo3IzB65MWTdMxBJxVUODXMGBO21ssZsMRb7XnKwVkzz6sxY
X-Gm-Gg: AYBFou3QiZvwBgqzfrwGJfooHAoTYwSW1z4vZ40Qjv+QDWi65agdmsTQ43LsyedoAvo
	AQKgARxqRYJXjv7pz2i/4j2oWWvcgWLTFWD06151a/fGRiRgaoVwAJybbKQ5TeE4/axY8h13cDn
	9h0XuQ/NVImYjRTHzjhDhaDjKSS9xYSotvoECEz41y6xCG7GrgJUAIvPt430XPTgft9mhb724eX
	sOb86mV7F3clOUiDksdu6MtK4MTL6kcE0Mw+nW9EABlnC8oei7wX+lyBCjVGl/qChJHjGkQRNie
	2ZeOBctdz8pJH4n+18x+fQX9fVL0IKkZQtQTmVT/vL2jOyhs9wKurBpKVPFQXUPBRZZiAaYeKfC
	hh5iijWDcZz9vA02l2IGBdE9NbQsMgbyRaqu8A+3xGI0sHyZmw/tLdrRPJybZulvEbqVisq5XnL
	OJsM9X9VpXQ7yrzfxDDufwqYAaSLKyQUrwIStiG+H/QBLpl581DHy+/YxCeA5ICozTl6GCLOA4N
	upryF43fSceusZgF/TGAjDy+u6REF68ud7sV1WOBbIqIevFFC4/F/zvHS5kfOwerTWIch8KRERQ
	ZH2WOyF9Tgt6wiONaGpsWVpRk2xyA6x8wsja++j1+DBEfLi+/UQgqEEj4J8sOh0GSW6ak4ra2bM
	lHV+dZ9th99y3G4X0yjHo6gJ8H3pfJAlU54HEQtfRNWIs53vgJZm2nFI=
X-Received: by 2002:a05:6a21:71cb:b0:3e0:c102:33d8 with SMTP id adf61e73a8af0-3e7cd5014c5mr6505768637.56.1793113312516;
        Tue, 27 Oct 2026 08:01:52 -0700 (PDT)
Received: from localhost ([153.61.198.252])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd8cccd63b6sm2848985a12.29.2026.10.27.08.01.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2026 08:01:51 -0700 (PDT)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 27 Oct 2026 15:01:50 +0000
Message-Id: <DMFPMAYUPSDU.2AW3225P0W0ON@gmail.com>
To: <sashiko-reviews@lists.linux.dev>, "Cai Xinchen"
 <caixinchen1@huawei.com>
Cc: <bpf@vger.kernel.org>, <linux-security-module@vger.kernel.org>,
 <linux-trace-kernel@vger.kernel.org>, <selinux@vger.kernel.org>,
 <dsterba@suse.cz>, "Chuck Lever" <cel@kernel.org>, "Jeff Layton"
 <jlayton@kernel.org>, "Anna Schumaker" <anna@kernel.org>
Subject: Re: [PATCH v3 -next 06/18] LSM: pass struct path and struct file to
 the inode xattr hooks
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
X-Mailer: aerc 0.20.1-349-gb940a4174a3e-dirty
References: <20261027121151.1887650-1-caixinchen1@huawei.com>
 <20261027121151.1887650-7-caixinchen1@huawei.com>
 <sashiko-outbox-186599@kernel.org>
In-Reply-To: <sashiko-outbox-186599@kernel.org>

On Tue Oct 27, 2026 at 1:02 PM UTC, sashiko-bot wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issu=
e(s) to consider:
> - [Critical] bpf: missing __nullable on file arg in inode xattr LSM hooks=
 allows NULL deref

bot is correct.
Please see commit 94e948b7e684 ("bpf: annotate file argument as __nullable =
in bpf_lsm_mmap_file")
and add to kernel/bpf/bpf_lsm_proto.c when args can be NULL.
That's how verifier knows.
