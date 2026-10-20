Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792520686;
	b=jrH1JOd/gES3IsaHK2v7bCrCwdwFXxPTEx7gJl3j2rBBW6/mmCW+TBfjw6A6hAafDJxa
	 K7ksV/YLhDyBERU/vENRTiLVgrxPxlubyUXIwEKjy57EOZOtw/jlmtYQkgFlxahbDZNXn
	 7mG2+8RUhRohXveqSkOYPxh/6v0RZeaMgBkDJF8GSsVIYW9KHD+JK22EW2Svv/ZYfv9t7
	 Oe/jrwZMknQzJAJVGjWDd0lVmu73wC1Vy7dEiZoTFHxrIESa2rFMqNLD+ynQt1eJCfxR1
	 GREUYOjUVNjwVE0Q7Cw7tnAmbLCYhQVwA3yuUb0zqwJnxN/DV67sJIpAWvnXWiRfsfw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792520686;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Subject:From:To:Cc:In-Reply-To:
	 References:X-Mailer:Content-Transfer-Encoding:MIME-Version;
	bh=8Qfir4WwcKrqoeimy2iPxwJM24Gz/gXh2B2PKiKQams=;
	b=Agn0qajWChUhjBDOefWjyfaw+TIdu/7uDu23TBxz5KMvJbs/vDng9AIaK662OmVVyb56
	 3x1yYLsvIqOEFo5rNwjE2Gn8YMXowL4ohYTbSHyIMOyH6ndOe8nqADUd/IgERe0wbxG0m
	 gYS5Y0eL1anyYa2egRxd8juUTuPu7SiM6umaiHwli05ZQ+qk0aOdp+2L73NMDGHib/avs
	 +2Ll6R1pkhVr/gWF69+GC9G9ddjLUjddSKGQT3VShZAlbN4kLWl1kRX90ZBTVdeO9qJT+
	 F4YqzVGW6/NrfxOsdNV16SBxCGkuLd/4885/Fi8OCdBsiwBePKXRXHPMtI5Ut79K0ZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=BGtd62Oe;
	arc=none smtp.remote-ip=209.85.216.44
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A050E606A31E
	for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 18:24:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A050E606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=BGtd62Oe
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3a4cdc9025bso2299915a91.0
        for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 11:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792520685; x=1793125485; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:cc:to
         :from:subject:message-id:date:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8Qfir4WwcKrqoeimy2iPxwJM24Gz/gXh2B2PKiKQams=;
        b=BGtd62OeWPju/vsAngLNxXqcgxNfyL6+oltPcIxN2sjko2c+R/Pjdl+lU60njYYNTn
         /RvenEldENHkj5P3LwKPrWJxxODoN2CF7ex4BbnlUAKayCIOifgNe6CIjrtTlVGoYw9p
         xRpxpKK1ZBGaHWqi1bhPWGtcrGYihNoL31M3s8YoHE65ncWM98dsuaiv9VPOVbYsuBSy
         78VFlK2gPYjHtVUozr899M0VDZXb/2WX8yMzec9LPoshvwVyKDLHbs+5gSovm7Yl0K8B
         p6QvYWvfPiynA3JnJpAtcz+NRJTTDSvuRFvkCQoQ8I5mKGPa8XLBgeJjx4pk+vWA4Zm/
         YMyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792520685; x=1793125485;
        h=mime-version:content-transfer-encoding:references:in-reply-to:cc:to
         :from:subject:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8Qfir4WwcKrqoeimy2iPxwJM24Gz/gXh2B2PKiKQams=;
        b=1skXJBPMLHm+0Ita9Js73fWjPJdWwVfLm8xE8yB3082z77Biv6GF+07K7aHFUw0CLe
         4o6sMhPH+NKlnGS7GV7DcPpD00z9owRuox11VaRgfybxMSASpLdHd4KR1zzdQW0DBZBJ
         Esb1Th6ZCHGJtAZBYrQZQAslAan+0yULwGuXHi1c1RE1XOljiOdh3gzBYCW6WFd4YimN
         ZjyubECC5N5EldVVbffdD3yaWeJqLnHow/BCDHcMr5unzrUsfxi60kZa9tEE2gPqPkFr
         RVGn1ftN/bo1BONnEctnz/z4Vzzw3fZ7tmDZbqgX7oyz+/LE4Wwup7nVriwmJ/PSvWUj
         d5eQ==
X-Forwarded-Encrypted: i=1; AKwUvBxMOcCqgzv1WmhqgPX7eXE5+oLZmvcBi4WzYEfgfa0+HEmZppxAbb22lXbYWUz4URhV/Dw=@vger.kernel.org
X-Gm-Message-State: AFq9FYJYve7HMAFRNEoLWAPCBxdEX2XwhHMQAfmAdKaow+iGVcVsgAxn
	XDuhD700KQUmu1+qWId0DuB9bvB6ghOpnhFnEyintyHE4na6iCJWke63
X-Gm-Gg: AYBFou2ZKldlPBQuwMsJqyU1Wu3ovfTx9zb7XogxprLdeUoc8o0btYZMhXWn4LxxNou
	yhjcpSiSGHogOL85RZzFl18U9sExQGzbq4xMgzYkvV3T+fjPk8X12HSyeBqFplRkfxBwrhmo2Sm
	kEijahPgetHcPioKMQwmGyIZdrXJlnSpcjLERTPQzPg+NAyHYdRtthvqDSs5RcEJ56uKMZuaCa1
	DOgl23DRMMXm4oArJnUroEBKAxyfdEx9nNX2PYwStYi+1tqXsed5SwW1FOs/c6i+i9E6roDL4yN
	VrptcFVuG6ciMsa1udgWGO9CMypTDjv4pdC3pL/tJk1Vks+jd/o/iExQRQYE2M3IjQ9Gfg6EuOf
	tIHxzHJn816afpwtuf3/h/GSQnPmVxx6nFEMUoC0xUWcKuA9hH6B3p9kTqIoOUeQkI+t9ZrpRI4
	YfGQmjDs39lY9HmpnhqyOaaG5opaMMqLA9mSnEfmOMQ+LWBxzaYeYvZmsPy2/EOABiTxnPfXMZG
	/++BboH1T7maozMXxirbhPH63G5CKQWBg8EBPdwVFgps2WTeKhqt0Ffesz4CFrCale+vBlEIFtN
	vDmw
X-Received: by 2002:a17:90b:1d4d:b0:3ac:86a0:5764 with SMTP id 98e67ed59e1d1-3acef5f0687mr8948009a91.64.1792520684886;
        Tue, 20 Oct 2026 11:24:44 -0700 (PDT)
Received: from localhost ([153.61.198.253])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ad835fada1sm173708a91.1.2026.10.20.11.24.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Oct 2026 11:24:44 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Tue, 20 Oct 2026 18:24:42 +0000
Message-Id: <DM9VJTFJGVXB.3GH9LO3NGV5PO@gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: fix crash in bpf_path_d_path() for
 exiting tasks
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Matt Bobrowski" <matt@bobrowski.net>, <bpf@vger.kernel.org>
Cc: "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Eduard Zingerman" <eddyz87@gmail.com>, "Kumar
 Kartikeya Dwivedi" <memxor@gmail.com>, "Martin KaFai Lau"
 <martin.lau@linux.dev>, "Song Liu" <song@kernel.org>, "Yonghong Song"
 <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>, "Emil
 Tsalapatis" <emil@etsalapatis.com>, "Ihor Solodrai"
 <ihor.solodrai@linux.dev>, "Christian Brauner" <brauner@kernel.org>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>, "Jan Kara" <jack@suse.cz>,
 <linux-fsdevel@vger.kernel.org>, <stable@vger.kernel.org>
In-Reply-To: <20261020105014.97985-2-matt@bobrowski.net>
References: <20261020105014.97985-1-matt@bobrowski.net> <20261020105014.97985-2-matt@bobrowski.net>
X-Mailer: mkdraft (claude review draft; edit before sending)
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

On Tue, Oct 20, 2026 at 03:50 AM Matt Bobrowski <matt@bobrowski.net> wrote:
> Fix this by returning -EINVAL from bpf_path_d_path() when current->fs
> is NULL. Only the task itself clears its fs, in exit_fs(), so the check
> cannot race with that.

The crash is gone, but so is the path. file_release progs will get
-EINVAL for every file that a task still has open when it exits.

It also breaks what works today. The d_dname branch in d_path() returns
before it looks at current->fs, so at task exit a pipe or a socket
resolves to "pipe:[123]" now and to -EINVAL with this patch.

And it's not specific to bpf. The comment in fs/cachefiles/namei.c says
that current->fs == NULL in do_exit() breaks d_path() called from ext4
open.

can we fix it in d_path() instead ?
With an empty root prepend_path() goes up to the global root, the same
way d_absolute_path() does. Then the check in bpf_path_d_path() is not
needed and the selftest can expect the path. A chrooted task gets the
path from the global root, but it doesn't have a root anymore.

Something like this (compile tested only):

diff --git a/fs/d_path.c b/fs/d_path.c
index c253090..ea49d33 100644
--- a/fs/d_path.c
+++ b/fs/d_path.c
@@ -265,7 +265,7 @@ static void get_fs_root_rcu(struct fs_struct *fs, struct path *root)
 char *d_path(const struct path *path, char *buf, int buflen)
 {
 	DECLARE_BUFFER(b, buf, buflen);
-	struct path root;
+	struct path root = {};

 	/*
 	 * We have various synthetic filesystems that never get mounted.  On
@@ -284,7 +284,9 @@ char *d_path(const struct path *path, char *buf, int buflen)
 		return path->dentry->d_op->d_dname(path->dentry, buf, buflen);

 	rcu_read_lock();
-	get_fs_root_rcu(current->fs, &root);
+	/* Past exit_fs() there is no root to stop at, go up to the global one. */
+	if (current->fs)
+		get_fs_root_rcu(current->fs, &root);
 	if (unlikely(d_unlinked(path->dentry)))
 		prepend(&b, " (deleted)", 11);
 	else

pw-bot: cr
