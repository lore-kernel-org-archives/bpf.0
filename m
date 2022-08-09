Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D7CEC3F6B0
	for <bpf@archiver.kernel.org>; Tue,  9 Aug 2022 14:31:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231459AbiHIObM convert rfc822-to-8bit (ORCPT
        <rfc822;bpf@archiver.kernel.org>); Tue, 9 Aug 2022 10:31:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbiHIObK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Aug 2022 10:31:10 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0207917AA3;
        Tue,  9 Aug 2022 07:31:08 -0700 (PDT)
Received: (Authenticated sender: hadess@hadess.net)
        by mail.gandi.net (Postfix) with ESMTPSA id AEBB3E0004;
        Tue,  9 Aug 2022 14:31:04 +0000 (UTC)
Message-ID: <2cde406b4d59ddfe71a7cdc11a76913a0a168595.camel@hadess.net>
Subject: Re: [PATCH 2/2] usb: Implement usb_revoke() BPF function
From:   Bastien Nocera <hadess@hadess.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, bpf@vger.kernel.org,
        Alan Stern <stern@rowland.harvard.edu>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Peter Hutterer <peter.hutterer@who-t.net>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Date:   Tue, 09 Aug 2022 16:31:04 +0200
In-Reply-To: <YvI5DJnOjhJbNnNO@kroah.com>
References: <20220809094300.83116-1-hadess@hadess.net>
         <20220809094300.83116-3-hadess@hadess.net> <YvI5DJnOjhJbNnNO@kroah.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4 (3.44.4-1.fc36) 
MIME-Version: 1.0
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 2022-08-09 at 12:38 +0200, Greg Kroah-Hartman wrote:
> Now if you really really want to disable a device from under a user,
> without the file handle present, you can do that today, as root, by
> doing the 'unbind' hack through userspace and sysfs.  It's so common
> that this seems to be how virtual device managers handle virtual
> machines, so it should be well tested by now.

The only thing I know that works that way is usbip, and it requires
unbinding each of the interfaces:

https://sourceforge.net/p/usbip/git-windows/ci/master/tree/trunk/userspace/src/bind-driver.c#l157

That means that, for example, revoking access to the raw USB device
that OpenRGB used to blink colours across a keyboard would disconnect
the keyboard from the HID device.

Can you show me any other users of that "trick" that would keep the
"hid" keyboard driver working while access to the /dev/bus/usb/* device
node is revoked/closed/yanked/unbound?

And if you can't, I would appreciate some efforts being made trying to
understand the use case, along with the limitations we're working
against, so we can find a good solution to the problem, instead of
retreading discussion points.
